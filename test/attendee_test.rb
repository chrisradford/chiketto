require 'test_helper'

class AttendeeTest < MiniTest::Test
  def test_exposes_data
    attendee = Chiketto::Attendee.new
    assert_respond_to attendee, :id
    assert_respond_to attendee, :email
    assert_respond_to attendee, :quantity
    assert_respond_to attendee, :status
    assert_respond_to attendee, :ticket_id
    assert_respond_to attendee, :answers
  end

  def test_attr_date_types
    attendee = Chiketto::Attendee.new created: "2014-02-11T02:52:10Z",
                                      changed: "2014-02-11T02:52:11Z"
    assert_kind_of DateTime, attendee.created
    assert_kind_of DateTime, attendee.changed
  end
end
