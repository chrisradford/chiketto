module Chiketto
  class Address < Resource
    attr_accessor :city,
                  :country,
                  :region,
                  :address_1,
                  :address_2,
                  :country_name

    def to_s
      [@address_1, @address_2, @city, @region, @country].
        reject { |p| p.nil? }.join(', ')
    end
  end
end
