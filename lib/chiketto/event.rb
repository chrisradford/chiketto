module Chiketto
  class Event < Resource
    class << self
      def find(id)
        event = get "events/#{id}"
        Event.new event
      end
    end
  end
end
