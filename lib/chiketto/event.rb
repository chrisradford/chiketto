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

    def self.create(params)
      params[:title] = params.delete(:name) if params[:name]
      response = Event.post 'event_new', params
      if response.fetch('process', false)
        Event.find response['process']['id']
      end
    end

    def self.find(id)
      event = get "events/#{id}"
      Event.new event
    end

    def self.search(params = {})
      events = get 'events/search', params
      events['events'].map { |event| Event.new event }
    end

    def attendees(params = {})
      attendees = Event.find_attendees @id, params
      attendees['attendees'].map { |att| Attendee.new att }
    end

    def organizer
      Organizer.new @organizer.to_h
    end

    def ticket_classes
      @ticket_classes.map do |t_class|
        TicketClass.new t_class.to_h
      end
    end

    def update(params)
      params[:id] = @id
      params[:title] = params.delete(:name) if params[:name]
      response = Event.post 'event_update', params
      if response.fetch('process', false)
        response['process']['status'].upcase == 'OK'
      end
    end

    def venue
      Venue.new @venue.to_h
    end

    private

    def self.find_attendees(id, params)
      get "events/#{id}/attendees", params
    end
  end
end
