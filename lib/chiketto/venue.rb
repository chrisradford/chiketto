module Chiketto
  class Venue < Resource
    attr_accessor :name

    def location
      Chiketto::Address.new @location.to_h
    end

    def to_s
      @name
    end
  end
end
