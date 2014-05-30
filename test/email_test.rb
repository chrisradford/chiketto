require 'test_helper'

class EmailTest < MiniTest::Test
  def test_exposes_data
    @email = Chiketto::Email.new
    assert_respond_to @email, :email
    assert_respond_to @email, :verified
    assert_respond_to @email, :primary
  end
end
