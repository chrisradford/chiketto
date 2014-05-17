require 'test_helper'

class TicketClassTest < MiniTest::Test

  def setup
    @tclass = Chiketto::TicketClass.new({
      "id" => "22315349", 
      "name" => "General Admission", 
      "cost" => nil, 
      "fee" => nil, 
      "currency" => nil, 
      "free" => true, 
      "minimum_quantity" => 1, 
      "maximum_quantity" => nil, 
      "quantity_total" => 19999, 
      "quantity_sold" => 1000, 
      "sales_start" => nil, 
      "sales_end" =>  "2014-12-01T22:59:59Z"
    });
  end

  def test_ticket_class_responds_to_methods
    assert_respond_to @tclass, :id
    assert_respond_to @tclass, :name
    assert_respond_to @tclass, :cost
    assert_respond_to @tclass, :fee
    assert_respond_to @tclass, :currency
    assert_respond_to @tclass, :free
    assert_respond_to @tclass, :minimum_quantity
    assert_respond_to @tclass, :maximum_quantity
    assert_respond_to @tclass, :quantity_total
    assert_respond_to @tclass, :quantity_sold
    assert_respond_to @tclass, :sales_start
    assert_respond_to @tclass, :sales_end
  end
end
