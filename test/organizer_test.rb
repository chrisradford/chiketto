require 'test_helper'

class OrganizerTest < MiniTest::Test
  def setup
    @organizer = Chiketto::Organizer.new 'description' => {
        'text' => 'Description of the Example Organizer', 
        'html' => '<p>Description of the Example Organizer</p>'
      }, 
      'id' => '1667263718', 
      'name' => 'Example Organizer'
  end

  def test_responds_to_methods
    assert_respond_to @organizer, :description
    assert_respond_to @organizer, :id
    assert_respond_to @organizer, :name
  end

  def test_description_is_an_attribute
    assert_respond_to @organizer.description, :html
    assert_respond_to @organizer.description, :text
  end

  def test_can_create_new_organizer
    VCR.use_cassette 'organizer-create-new' do
      organizer = Chiketto::Organizer.create name: 'New Organizer'
      assert_kind_of Fixnum, organizer
    end
  end

  def test_cannot_create_an_existing_organizer
    VCR.use_cassette 'organizer-create' do
      assert_raises RuntimeError do
        Chiketto::Organizer.create name: 'Test Organizer'
      end
    end
  end
end
