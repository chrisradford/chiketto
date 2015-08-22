module Chiketto
  class Venue < Resource
    attr_accessor :name

    def self.find(id)
      response = get "venues/#{id}"
      new response
    end

    def address
      Chiketto::Address.new @address.to_h
    end

    def to_s
      @name
    end
  end
end
