require "test_helper"

class NoteTest < ActiveSupport::TestCase
  test "validates presence of POC" do
    note = build(:note, poc: "")

    assert_not note.valid?
    assert_equal ["can't be blank"], note.errors[:poc]
  end

  test "normalizes poc field" do
    note = create(:note, poc: "  My POC  ")

    assert_equal "My POC", note.poc
  end
end
