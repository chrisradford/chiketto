require 'test_helper'

class ContactListTest < MiniTest::Test
  def test_contact_list_exposes_data
    contact_list = Chiketto::ContactList.new
    assert_respond_to contact_list, :name
  end
end
