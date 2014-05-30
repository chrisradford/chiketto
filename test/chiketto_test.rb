require 'test_helper'

class ChikettoTest < MiniTest::Test
  def test_should_manage_an_api_key
    assert_equal ENV['EVENTBRITE_API_TOKEN'], Chiketto.api_key
    Chiketto.api_key = '123456'
    assert_equal '123456', Chiketto.api_key
    Chiketto.api_key = ENV['EVENTBRITE_API_TOKEN']
  end
end
