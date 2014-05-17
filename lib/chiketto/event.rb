module Chiketto
  class Event < Resource

    attr_reader :resource_uri,
                :url,
                :capacity,
                :categories,
                :status

    attr_attrib :description,
                :name

    attr_date   :start,
                :end,
                :created,
                :changed

    def organizer
      Chiketto::Organizer.new Hash(@organizer)
    end

    def ticket_classes
      @ticket_classes.map do |t_class|
        Chiketto::TicketClass.new t_class
      end
    end

    def venue
      Chiketto::Venue.new Hash(@venue)
    end

    def self.find(id)
      event = get "events/#{id}"
      Event.new event
    end
  end
end
