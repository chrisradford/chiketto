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
    assert_respond_to @event, :category
    assert_respond_to @event, :subcategory
    assert_respond_to @event, :status
    assert_respond_to @event, :listed?
    assert_respond_to @event, :logo
    assert_respond_to @event, :logo_url
    assert_respond_to @event, :questions
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

  def test_categories_are_objects
    find_event
    assert_kind_of Chiketto::Category, @event.category
    assert_kind_of Chiketto::Category, @event.subcategory
  end

  def test_questions_are_objects
    find_event
    VCR.use_cassette 'event-questions' do
      assert_kind_of Array, @event.questions
      assert_kind_of Chiketto::Question, @event.questions.first
    end
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

  def test_listed_is_always_set
    find_event
    assert_kind_of FalseClass, @event.listed?
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
    refute @attendees.empty?, 'Should return more than 0 attendees'
  end

  def test_attendees_returns_an_array_of_attendees_attending
    find_event
    VCR.use_cassette 'event-attendees-attending' do
      @attendees = @event.attendees status: 'attending'
    end
    assert_kind_of Array, @attendees
  end

  def test_attendees_returns_an_array_of_attendees_with_assigned_numbers
    find_event
    VCR.use_cassette 'event-attendees-expand-assigned' do
      @attendees = @event.attendees expand: 'assigned_number'
    end
    assert_kind_of Array, @attendees
  end

  def test_updates_event_with_params
    VCR.use_cassette 'event-update' do
      find_event
      event = @event.update 'event.name.html' => 'Movember 2014'
      assert_kind_of Chiketto::Event, event
      @event = Chiketto::Event.find @event.id
      assert_equal 'Movember 2014', @event.name.to_s
    end
  end

  def test_update_returns_false_for_invalid_id
    VCR.use_cassette 'event-update-failure' do
      assert_raises Chiketto::Exception do
        event = Chiketto::Event.new id: '12345'
        event.update 'event.name.html' => 'Movember 2014'
      end
    end
  end

  def test_create_a_new_event
    VCR.use_cassette 'event-create' do
      event = Chiketto::Event.create({
        'event.name.html' => 'Test Event Creation',
        'event.start.utc' => '2018-05-12T02:00:00Z',
        'event.start.timezone' => 'Europe/London',
        'event.end.utc' => '2018-05-12T08:00:00Z',
        'event.end.timezone' => 'Europe/London',
        'event.currency' => 'USD',
      })
      assert_kind_of Chiketto::Event, event
      assert_equal 'Test Event Creation', event.name.to_s
    end
  end

  def test_create_an_event_returns_false_on_failure
    VCR.use_cassette 'event-create-failure' do
      assert_raises Chiketto::Exception do
        Chiketto::Event.create 'event.name.html' => 'Test Event'
      end
    end
  end
end
