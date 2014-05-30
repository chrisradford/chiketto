require 'test_helper'

class EmailTest < MiniTest::Test
  def test_exposes_data
    @email = Chiketto::Email.new
    assert_respond_to @email, :email
    assert_respond_to @email, :verified
    assert_respond_to @email, :primary
  end

  def test_returns_email_for_to_s
    @email = Chiketto::Email.new({ email: 'test@example.com' })
    assert_equal 'test@example.com', @email.to_s
  end
end
