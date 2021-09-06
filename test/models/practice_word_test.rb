require "test_helper"

class PracticeWordTest < ActiveSupport::TestCase
  test "validates presence of name" do
    practice_word = build(:practice_word, name: "")

    assert_not practice_word.valid?
    assert_equal ["can't be blank"], practice_word.errors[:name]
  end

  test "normalizes name field" do
    practice_word = create(:practice_word, name: " bird ")

    assert_equal "bird", practice_word.name
  end

  test "normalizes word_error field" do
    practice_word = create(:practice_word, word_error: " bird ")

    assert_equal "bird", practice_word.word_error
  end

  test "normalizes additional_info field" do
    practice_word = create(:practice_word, additional_info: " bird ")

    assert_equal "bird", practice_word.additional_info
  end
end
