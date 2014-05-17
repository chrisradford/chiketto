module Chiketto
  class Event < Resource

    attr_reader :resource_uri,
                :organizer,
                :venue,
                :ticket_classes,
                :url,
                :start,
                :end,
                :created,
                :changed,
                :timezone,
                :capacity,
                :categories,
                :status

    def name
      Chiketto::Attribute.new @name
    end

    def description
      Chiketto::Attribute.new @description
    end

    class << self
      def find(id)
        event = get "events/#{id}"
        Event.new event
      end
    end
  end
end
