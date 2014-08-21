module Chiketto
  class Attendee < Resource
    attr_accessor :quantity,
                  :status,
                  :ticket_class_id,
                  :event_id,
                  :order_id,
                  :assigned_number

    attr_date :changed,
              :created

    def profile
      AttendeeProfile.new @profile.to_h
    end

    def addresses
      @addresses.to_h.inject({}) do |hash, (key, address)|
        hash.merge(key.to_sym => Address.new(address.to_h))
      end
    end
  end
end
