module Chiketto
  class Organizer < Resource
    attr_accessor :name

    attr_attrib :description

    def self.find(id)
      response = get "organizers/#{id}"
      Organizer.new response
    end

    def self.create(params)
      response = post 'organizers', params
      Chiketto::Organizer.new response
    end
  end
end
