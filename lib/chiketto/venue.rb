module Chiketto
  class Venue < Resource
    attr_accessor :latitude,
                  :longitude,
                  :name

    def address
      Chiketto::Address.new Hash.new(@address)
    end
  end
end
