require "test_helper"

class PatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patients = create_list(:patient, 5)
  end

  test "lists all the patients" do
    get patients_path

    assert_equal 5, assigns(:patients).count
  end
end
