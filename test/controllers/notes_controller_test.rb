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
  end
end
