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

    def self.find(id)
      event = get "events/#{id}"
      Event.new event
    end

    def self.search(params = {})
      events = get 'events/search', params
      events['events'].map { |event| Event.new event }
    end

    def attendees(params = {})
      attendees = Chiketto::Event.find_attendees @id, params
      attendees['attendees'].map { |att| Attendee.new att }
    end

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

    private

    def self.find_attendees(id, params)
      attendees = get "events/#{id}/attendees", params
    end
  end
end
