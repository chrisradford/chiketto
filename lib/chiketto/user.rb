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

    def event_attendees(params = {})
      attendees = User.paginated_attendees @id, params
      attendees.map { |e| Attendee.new e }
    end

    def organizers
      organizers = User.find_organizers @id
      organizers['organizers'].map { |o| Organizer.new o }
    end

    def contact_lists(params = {})
      contact_lists = User.paginated(:contact_lists, @id, params)
      contact_lists.map { |cl| ContactList.new cl }
    end

    def find_contact_list(contact_list_id)
      contact_list = User.get "users/#{@id}/contact_lists/#{contact_list_id}"
      ContactList.new contact_list
    end

    def create_contact_list(params)
      response = User.post "users/#{@id}/contact_lists/", params
      ContactList.new response
    end

    private

    def self.find_attendees(id, params)
      get "users/#{id}/owned_event_attendees", params
    end

    def self.find_events(id, params)
      get "users/#{id}/owned_events", params
    end

    def self.find_organizers(id)
      get "users/#{id}/organizers"
    end

    def self.find_contact_lists(id, params)
      get "users/#{id}/contact_lists", params
    end

    def self.paginated_events(id, params)
      paginated(:events, id, params)
    end

    def self.paginated_attendees(id, params)
      paginated(:attendees, id, params)
    end
  end
end
