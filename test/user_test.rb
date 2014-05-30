require 'test_helper'

class UserTest < MiniTest::Test
  USER_ID = 72013652427

  def find_me
    VCR.use_cassette 'user-me' do
      @user = Chiketto::User.find
    end
  end

  def test_exposes_data
    @user = Chiketto::User.new
    assert_respond_to @user, :id
    assert_respond_to @user, :name
    assert_respond_to @user, :email
    assert_respond_to @user, :first_name
    assert_respond_to @user, :last_name
  end

  def test_find_without_id
    find_me
    assert_kind_of Chiketto::User, @user
  end

  def test_find_with_id
    VCR.use_cassette 'user-id' do
      @user = Chiketto::User.find USER_ID
    end
    assert_kind_of Chiketto::User, @user
  end

  def test_user_has_emails
    find_me
    assert_kind_of Array, @user.emails
    assert_kind_of Chiketto::Email, @user.emails.first
  end

  def test_user_has_email_for_primary_only
    find_me
    assert_kind_of Chiketto::Email, @user.email
  end
end
