require 'test_helper'

class AddressTest < MiniTest::Test
  def setup
    @address = Chiketto::Address.new({
      'city' => 'San Francisco',
      'country' => 'US',
      'region' => 'CA',
      'address_1' => '651 Brannan',
      'address_2' => 'Suite 110',
      'country_name' => 'United States'
    })
  end

  def test_responds_to_methods
    assert_respond_to @address, :city
    assert_respond_to @address, :country
    assert_respond_to @address, :region
    assert_respond_to @address, :address_1
    assert_respond_to @address, :address_2
    assert_respond_to @address, :country_name
  end

  def test_responds_to_string_method
    assert_equal '651 Brannan, Suite 110, San Francisco, CA, US', @address.to_s
  end

  def test_does_not_include_blanks_in_string
    @address.region = nil
    assert_equal '651 Brannan, Suite 110, San Francisco, US', @address.to_s
  end
end
