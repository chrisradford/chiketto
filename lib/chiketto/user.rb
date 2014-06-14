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
      @emails.map { |email| Chiketto::Email.new email }
    end

    def events(params = {})
      events = Chiketto::User.find_events @id, params
      events['events'].map { |e| Chiketto::Event.new e }
    end

    private

    def self.find_events(id, params)
      get "users/#{id}/owned_events", params
    end
  end
end
