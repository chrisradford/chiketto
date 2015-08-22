require 'test_helper'

class UserTest < MiniTest::Test
  USER_ID = 72013652427
  CONTACT_LIST_ID = 411987

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

  def test_user_has_events
    find_me

    VCR.use_cassette 'user-events' do
      assert_kind_of Chiketto::Event, @user.events.first
    end
  end

  def test_user_has_event_attendees
    find_me

    VCR.use_cassette 'user-event-attendees' do
      assert_kind_of Chiketto::Attendee, @user.event_attendees.first
    end
  end

  def test_user_has_organizers
    find_me

    VCR.use_cassette 'user-organizers' do
      assert_kind_of Chiketto::Organizer, @user.organizers.first
    end
  end

  def test_user_has_contact_lists
    find_me

    VCR.use_cassette 'user-contact-lists' do
      assert_kind_of Chiketto::ContactList, @user.contact_lists.first
    end
  end

  def test_user_find_contact_list_returns_contact_list
    find_me

    VCR.use_cassette 'user-find-contact-list' do
      assert_kind_of Chiketto::ContactList, @user.find_contact_list(CONTACT_LIST_ID)
    end
  end

  def test_create_contact_list
    find_me

    VCR.use_cassette 'user-create-contact-list' do
      contact_list = @user.create_contact_list({
        'contact_list.name' => 'Test Contact List Creation'
      })
      assert_kind_of Chiketto::ContactList, contact_list
      assert_equal 'Test Contact List Creation', contact_list.name
    end
  end
end
