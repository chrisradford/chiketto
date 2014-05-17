module Chiketto
  class Venue < Resource
    attr_accessor :latitude,
                  :longitude,
                  :name

    def address
      Chiketto::Address.new @address
    end
  end
end
