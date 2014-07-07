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
      events = User.find_events @id, params
      events['events'].map { |e| Event.new e }
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
  end
end
