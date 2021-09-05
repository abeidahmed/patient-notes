require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient = create(:patient)
  end

  test "instantiating a new note" do
    get new_patient_note_path(@patient)

    assert_response :ok
  end

  test "creating a note with valid params" do
    assert_difference "@patient.notes.count" do
      post patient_notes_path(@patient), params: {note: {poc: "STG3: labeled vocabulary (nouns, verbs) -visual/mod cues"}}
    end
  end

  test "creating a note with practice words nested" do
    assert_difference "@patient.notes.count" do
      post patient_notes_path(@patient), params: {
        note: {poc: "Anything", practice_words_attributes: [
          {name: "/sh/", word_error: "Shard, Shark", additional_info: "Any other information"}
        ]}
      }
    end

    assert_equal 1, Note.last.practice_words.count
  end

  test "creating a note with an unknown practice word" do
    post patient_notes_path(@patient), params: {
      note: {poc: "Anything", practice_words_attributes: [
        {name: "", word_error: "Shard, Shark", additional_info: "Any other information"}
      ]}
    }

    assert Note.last.practice_words.count.zero?
  end

  test "creating a note with pronunciation results" do
    post patient_notes_path(@patient), params: {
      note: {poc: "Anything", practice_words_attributes: [
        {
          name: "/sh/",
          word_error: "Shard, Shark",
          additional_info: "Any other information",
          pronunciations_attributes: [{result: "pronounced"}, {result: "mispronounced"}]
        }
      ]}
    }

    assert_equal 2, PracticeWord.last.pronunciations.count
  end
end
