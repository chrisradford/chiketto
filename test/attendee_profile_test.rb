require 'test_helper'

class AttendeeProfileTest < MiniTest::Test
  def test_exposes_data
    attendee_profile = Chiketto::AttendeeProfile.new
    assert_respond_to attendee_profile, :first_name
    assert_respond_to attendee_profile, :last_name
    assert_respond_to attendee_profile, :email
    assert_respond_to attendee_profile, :name
    assert_respond_to attendee_profile, :prefix
    assert_respond_to attendee_profile, :suffix
    assert_respond_to attendee_profile, :age
    assert_respond_to attendee_profile, :job_title
    assert_respond_to attendee_profile, :company
    assert_respond_to attendee_profile, :website
    assert_respond_to attendee_profile, :blog
    assert_respond_to attendee_profile, :gender
    assert_respond_to attendee_profile, :birth_date
    assert_respond_to attendee_profile, :cell_phone
  end
end
