require 'test_helper'

class AttendeeTest < MiniTest::Test
  def test_exposes_data
    attendee = Chiketto::Attendee.new
    assert_respond_to attendee, :ticket_class_id
    assert_respond_to attendee, :quantity
    assert_respond_to attendee, :status
    assert_respond_to attendee, :profile
    assert_respond_to attendee, :event_id
    assert_respond_to attendee, :order_id
    assert_respond_to attendee, :assigned_number
    assert_respond_to attendee, :answers
    assert_respond_to attendee, :barcodes
  end

  def test_attr_date_types
    attendee = Chiketto::Attendee.new created: "2014-02-11T02:52:10Z",
                                      changed: "2014-02-11T02:52:11Z"
    assert_kind_of DateTime, attendee.created
    assert_kind_of DateTime, attendee.changed
  end

  def test_attendee_returns_profile
    attendee = Chiketto::Attendee.new
    assert_kind_of Chiketto::AttendeeProfile, attendee.profile
  end

  def test_assigned_number_is_handled
    attendee = Chiketto::Attendee.new assigned_number: 1
    assert_equal attendee.assigned_number, 1
  end
end
