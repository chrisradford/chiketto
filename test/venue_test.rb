require 'test_helper'

class VenueTest < MiniTest::Test
  def test_venue_methods_exist
    @venue = Chiketto::Venue.new({
      'id' => '545454',
      'address' => {
        'city' => 'San Francisco',
        'country' => 'US',
        'region' => 'CA',
        'address_1' => '651 Brannan',
        'address_2' => 'Suite 110',
        'country_name' => 'United States'
      },
      'latitude' => '42.3618641',
      'longitude' => '-71.0905626',
      'name' => 'Eventbrite HQ'
    })

    assert_respond_to @venue, :id
    assert_respond_to @venue, :address
    assert_respond_to @venue, :latitude
    assert_respond_to @venue, :longitude
    assert_respond_to @venue, :name
  end

  def test_venue_with_no_address
    @venue = Chiketto::Venue.new({
      'id' => '545454',
      'latitude' => '42.3618641',
      'longitude' => '-71.0905626',
      'name' => 'Eventbrite HQ'
    })

    assert_respond_to @venue.address, :to_s
  end
end
