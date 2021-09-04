require "test_helper"

class PracticeWordTest < ActiveSupport::TestCase
  test "validates presence of name" do
    practice_word = build(:practice_word, name: "")

    assert_not practice_word.valid?
    assert_equal ["can't be blank"], practice_word.errors[:name]
  end
end
