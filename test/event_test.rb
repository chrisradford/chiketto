require 'test_helper'

class EventTest < MiniTest::Test
  TEST_ID = '9203575141'

  def find_event
    VCR.use_cassette 'event-find' do
      @event = Chiketto::Event.find TEST_ID
    end
  end

  def search_events
    VCR.use_cassette 'event-search' do
      @events = Chiketto::Event.search q: 'Test Event'
    end
  end

  def test_fetching_event
    find_event
    assert_kind_of Chiketto::Event, @event
    assert_equal @event.id, TEST_ID
  end

  def test_event_exposes_data
    find_event
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
    find_event
    assert_respond_to @event.name, :html
    assert_respond_to @event.name, :text
    refute @event.name.html.empty?, "Should not return an empty name"
    refute @event.name.text.empty?, "Should not return an empty name"
  end

  def test_description_attribute_is_valid
    find_event
    assert_respond_to @event.description, :html
    assert_respond_to @event.description, :text
  end

  def test_organizer_is_object
    find_event
    assert_kind_of Chiketto::Organizer, @event.organizer
  end

  def test_venue_is_object
    find_event
    assert_kind_of Chiketto::Venue, @event.venue
  end

  def test_ticket_classes_is_object
    find_event
    assert_kind_of Chiketto::TicketClass, @event.ticket_classes.first
  end

  def test_date_attributes
    find_event
    assert_kind_of DateTime, @event.end
    assert_kind_of DateTime, @event.start
    assert_kind_of DateTime, @event.created
    assert_kind_of DateTime, @event.changed
  end

  def test_search_returns_array_of_events
    search_events
    assert_kind_of Array, @events
    assert_kind_of Chiketto::Event, @events.first
  end

  def test_attendees_returns_an_array_of_attendees
    find_event
    VCR.use_cassette 'event-attendees' do
      @attendees = @event.attendees
    end
    assert_kind_of Array, @attendees
  end

  def test_attendees_returns_an_array_of_attendees_attending
    find_event
    VCR.use_cassette 'event-attendees-attending' do
      @attendees = @event.attendees status: 'attending'
    end
    assert_kind_of Array, @attendees
  end

  def test_updates_event_with_params
    VCR.use_cassette 'event-update' do
      find_event
      response = @event.update name: 'Movember 2014'
      assert response, 'Should return true after updating'
      @event = Chiketto::Event.find @event.id
      assert_equal 'Movember 2014', @event.name.to_s
    end
  end

  def test_update_returns_false_for_invalid_id
    VCR.use_cassette 'event-update-fail' do
      event = Chiketto::Event.new id: '12345'
      response = event.update name: 'Movember 2014'
      refute response, 'Should return false for invalid id'
    end
  end

  def test_create_a_new_event
    VCR.use_cassette 'event-create' do
      event = Chiketto::Event.create name: 'Test Event Creation',
        start_date: '2037-12-31 22:59:59', end_date: '2037-12-31 23:59:59'
      assert_kind_of Chiketto::Event, event
      assert_equal 'Test Event Creation', event.name.to_s
    end
  end

  def test_create_an_event_returns_false_on_failure
    VCR.use_cassette 'event-create-failure' do
      event = Chiketto::Event.create name: 'Test Event'
      refute event, 'Should return false when API rejects creation'
    end
  end
end
