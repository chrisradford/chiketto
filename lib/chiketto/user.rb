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
      emails.reject { |email| email.primary }.first
    end

    def emails
      @emails.map { |email| Chiketto::Email.new Hash.new(email) }
    end
  end
end
