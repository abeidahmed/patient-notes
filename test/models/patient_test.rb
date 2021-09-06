require "test_helper"

class PatientTest < ActiveSupport::TestCase
  test "validates presence of name" do
    patient = build(:patient, name: "")

    assert_not patient.valid?
    assert_equal ["can't be blank"], patient.errors[:name]
  end
end
