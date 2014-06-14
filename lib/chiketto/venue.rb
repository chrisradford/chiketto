module Chiketto
  class Venue < Resource
    attr_accessor :latitude,
                  :longitude,
                  :name

    def address
      Chiketto::Address.new @address.to_h
    end

    def to_s
      @name
    end
  end
end
