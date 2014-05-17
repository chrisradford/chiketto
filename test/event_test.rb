require 'test_helper'

class EventTest < MiniTest::Test
  def test_fetching_event
    VCR.use_cassette 'eventbriteapi' do
      event = Chiketto::Event.find 9203575141

      assert_equal event.id, '9203575141'
    end
  end

  def test_event_exposes_data
    VCR.use_cassette 'eventbriteapi' do
      event = Chiketto::Event.find 9203575141

      assert_respond_to event, :id
      assert_respond_to event, :name
      assert_respond_to event, :description
      assert_respond_to event, :resource_uri
      assert_respond_to event, :organizer
      assert_respond_to event, :venue
      assert_respond_to event, :ticket_classes
      assert_respond_to event, :url
      assert_respond_to event, :start
      assert_respond_to event, :end
      assert_respond_to event, :created
      assert_respond_to event, :changed
      assert_respond_to event, :timezone
      assert_respond_to event, :capacity
      assert_respond_to event, :categories
      assert_respond_to event, :status
    end
  end

  def test_name_attributes
    VCR.use_cassette 'eventbriteapi' do
      event = Chiketto::Event.find 9203575141

      assert_respond_to event.name, :html
      assert_respond_to event.name, :text
    end
  end

end
