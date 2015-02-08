module Chiketto
  class User < Resource
    attr_accessor :name,
                  :first_name,
                  :last_name

    def self.find(id = 'me')
      user = get "users/#{id}"
      User.new user
    end

    def email
      emails.detect { |email| email.primary }
    end

    def emails
      @emails.map { |email| Email.new email }
    end

    def events(params = {})
      events = User.paginated_events @id, params
      events.map { |e| Event.new e }
    end

    def organizers
      organizers = User.find_organizers @id
      organizers['organizers'].map { |o| Organizer.new o }
    end

    private

    def self.find_events(id, params)
      get "users/#{id}/owned_events", params
    end

    def self.find_organizers(id)
      get "users/#{id}/organizers"
    end

    def self.paginated_events(id, params)
      page = 0
      events = []
      loop do
        page += 1
        response = User.find_events id, params.merge(page: page.to_s)
        events.concat response['events']
        break unless should_paginate(response['pagination'])
      end
      events
    end
  end
end
