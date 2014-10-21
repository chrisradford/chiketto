module Chiketto
  class Address < Resource
    attr_accessor :city,
                  :country,
                  :region,
                  :address_1,
                  :address_2,
                  :postal_code,
                  :country_name,
                  :longitude,
                  :latitude

    def to_s
      [@address_1, @address_2, @city, @region, @postal_code, @country].
        reject { |p| p.nil? }.join(', ')
    end
  end
end
