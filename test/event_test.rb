require 'test_helper'

class EventTest < MiniTest::Test
  def test_fetching_event
    VCR.use_cassette 'eventbriteapi' do
      event = Chiketto::Event.find 9203575141
      assert_equal event.id, "9203575141", "Event did not have the correct id: #{event.id}"
    end
  end
end
