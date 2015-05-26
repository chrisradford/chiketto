module Chiketto
  class Organizer < Resource
    attr_accessor :name

    attr_attrib :description

    def self.create(params)
      response = Organizer.post 'organizers', params
      Chiketto::Organizer.new response
    end
  end
end
