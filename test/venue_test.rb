require 'test_helper'

class VenueTest < MiniTest::Test
  def basic_venue
    @venue = Chiketto::Venue.new 'id' => '545454',
      'name' => 'Eventbrite HQ'
  end

  def test_venue_methods_exist
    @venue = Chiketto::Venue.new 'id' => '545454',
      'location' => {
        'city' => 'San Francisco',
        'country' => 'US',
        'region' => 'CA',
        'address_1' => '651 Brannan',
        'address_2' => 'Suite 110',
        'country_name' => 'United States',
        'latitude' => '42.3618641',
        'longitude' => '-71.0905626',
      },
      'name' => 'Eventbrite HQ'

    assert_respond_to @venue, :id
    assert_respond_to @venue, :location
    assert_respond_to @venue, :name
  end

  def test_venue_with_no_address
    basic_venue
    assert_respond_to @venue.location, :to_s
    assert_respond_to @venue.location, :latitude
    assert_respond_to @venue.location, :longitude
  end

  def test_venue_returns_name_for_to_s
    basic_venue
    assert_equal @venue.to_s, @venue.name
  end
end
