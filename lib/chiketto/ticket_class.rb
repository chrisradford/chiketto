module Chiketto
  class TicketClass < Resource
    attr_accessor :name,
                  :cost,
                  :fee,
                  :currency,
                  :free,
                  :minimum_quantity,
                  :maximum_quantity,
                  :quantity_total,
                  :quantity_sold

    attr_date :sales_start,
              :sales_end

  end
end
