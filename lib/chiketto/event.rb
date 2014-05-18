module Chiketto
  class Event < Resource
    attr_reader :resource_uri,
                :url,
                :capacity,
                :categories,
                :status

    attr_attrib :description,
                :name

    attr_date :start,
              :end,
              :created,
              :changed

    def organizer
      Chiketto::Organizer.new Hash.new(@organizer)
    end

    def ticket_classes
      @ticket_classes.map do |t_class|
        Chiketto::TicketClass.new Hash.new(t_class)
      end
    end

    def venue
      Chiketto::Venue.new Hash.new(@venue)
    end

    def self.find(id)
      event = get "events/#{id}"
      Event.new event
    end

    def self.search(params = {})
      events = get 'events/search', params
      events['events'].map { |event| Event.new event }
    end
  end
end
