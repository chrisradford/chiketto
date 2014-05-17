require 'test_helper'

class EventTest < MiniTest::Test
  TEST_ID = '9203575141'

  def setup
    VCR.use_cassette 'eventbriteapi' do
      @event = Chiketto::Event.find TEST_ID
    end
  end

  def test_fetching_event
    assert_kind_of Chiketto::Event, @event
    assert_equal @event.id, TEST_ID
  end

  def test_event_exposes_data
    assert_respond_to @event, :id
    assert_respond_to @event, :name
    assert_respond_to @event, :description
    assert_respond_to @event, :resource_uri
    assert_respond_to @event, :organizer
    assert_respond_to @event, :venue
    assert_respond_to @event, :ticket_classes
    assert_respond_to @event, :url
    assert_respond_to @event, :start
    assert_respond_to @event, :end
    assert_respond_to @event, :created
    assert_respond_to @event, :changed
    assert_respond_to @event, :capacity
    assert_respond_to @event, :categories
    assert_respond_to @event, :status
  end

  def test_name_attribute_is_valid
    assert_respond_to @event.name, :html
    assert_respond_to @event.name, :text
  end

  def test_description_attribute_is_valid
    assert_respond_to @event.description, :html
    assert_respond_to @event.description, :text
  end

  def test_organizer_is_object
    assert_kind_of Chiketto::Organizer, @event.organizer
  end

  def test_venue_is_object
    assert_kind_of Chiketto::Venue, @event.venue
  end

  def test_ticket_classes_is_object
    assert_kind_of Chiketto::TicketClass, @event.ticket_classes.first
  end

  def test_date_attributes
    assert_kind_of DateTime, @event.end
    assert_kind_of DateTime, @event.start
    assert_kind_of DateTime, @event.created
    assert_kind_of DateTime, @event.changed
  end
end
