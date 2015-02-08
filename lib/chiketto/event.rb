module Chiketto
  class Event < Resource
    attr_reader :resource_uri,
                :url,
                :capacity,
                :status,
                :logo,
                :logo_url

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
      attendees = Event.paginated_attendees @id, params
      attendees.map { |att| Attendee.new att }
    end

    def category
      Category.new @category.to_h
    end

    def listed?
      !!@listed
    end

    def questions
      questions = Event.find_questions id
      questions['questions'].map { |question| Question.new question }
    end

    def organizer
      Organizer.new @organizer.to_h
    end

    def subcategory
      Category.new @subcategory.to_h
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

    def self.find_questions(id, params = {})
      get "events/#{id}/questions", params
    end

    def self.find_attendees(id, params = {})
      get "events/#{id}/attendees", params
    end

    def self.paginated_attendees(id, params)
      page = 0
      attendees = []
      loop do
        page += 1
        response = Event.find_attendees id, params.merge(page: page.to_s)
        attendees.concat response['attendees']
        break unless should_paginate(response['pagination'])
      end
      attendees
    end

    def self.should_paginate(pagination)
      pagination['page_count'] > pagination['page_number']
    end
  end
end
