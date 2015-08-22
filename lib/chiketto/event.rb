module Chiketto
  class Event < Resource
    attr_reader :resource_uri, :url, :capacity, :status, :logo, :logo_url,
                :organizer_id, :venue_id, :category_id, :subcategory_id
    attr_attrib :description, :name
    attr_date :start, :end, :created, :changed

    def self.create(params)
      response = Event.post 'events', params
      Event.new response
    end

    def self.find(id, params = {})
      event = get "events/#{id}", params
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
      @category = find_or_fetch_category(@category, @category_id)
    end

    def listed?
      !!@listed
    end

    def questions
      questions = Event.find_questions id
      questions['questions'].map { |question| Question.new question }
    end

    def organizer
      if @organizer.is_a?(Organizer)
        @organizer
      elsif @organizer
        @organizer = Organizer.new @organizer.to_h
      elsif @organizer_id
        @organizer = Organizer.find @organizer_id
      end
    end

    def subcategory
      @subcategory = find_or_fetch_category(@subcategory, @subcategory_id)
    end

    def ticket_classes
      return [] unless @ticket_classes
      @ticket_classes.map do |t_class|
        TicketClass.new t_class.to_h
      end
    end

    def update(params)
      response = Event.post "events/#{@id}", params
      Event.new response
    end

    def venue
      if @venue.is_a?(Venue)
        @venue
      elsif @venue
        @venue = Venue.new @venue.to_h
      elsif @venue_id
        @venue = Venue.find @venue_id
      end
    end

    private

    def find_or_fetch_category(category, category_id)
      if category.is_a?(Category)
        category
      elsif category
        Category.new category.to_h
      elsif category_id
        Category.find category_id
      end
    end

    def self.find_questions(id, params = {})
      get "events/#{id}/questions", params
    end

    def self.find_attendees(id, params = {})
      get "events/#{id}/attendees", params
    end

    def self.paginated_attendees(id, params)
      paginated(:attendees, id, params)
    end
  end
end
