module Chiketto
  class Attendee < Resource
    attr_accessor :quantity,
                  :status,
                  :ticket_class_id,
                  :event_id,
                  :order_id,
                  :assigned_number,
                  :answers,
                  :barcodes

    attr_date :changed,
              :created

    def profile
      AttendeeProfile.new @profile.to_h
    end
  end
end
