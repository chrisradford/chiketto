require 'test_helper'

class ChikettoTest < MiniTest::Test
  def test_should_manage_an_api_key
    ENV['EVENTBRITE_API_TOKEN'] = '654321'
    assert_equal '654321', Chiketto.api_key
    Chiketto.api_key = '123456'
    assert_equal '123456', Chiketto.api_key
  end
end
