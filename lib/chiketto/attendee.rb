module Chiketto
  class Attendee < Resource
    attr_accessor :email,
                  :quantity,
                  :status,
                  :ticket_id,
                  :answers

    attr_date :changed,
              :created
  end
end
