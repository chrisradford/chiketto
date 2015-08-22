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

  def test_creating_an_organizer
    VCR.use_cassette 'organizer-create' do
      name = ENV['CI'] ? Time.new.to_s : 'Test Organizer Name'
      organizer = Chiketto::Organizer.create 'organizer.name' => name
      assert_kind_of Chiketto::Organizer, organizer
      assert_equal name, organizer.name
    end
  end

  def test_cannot_create_an_existing_organizer
    VCR.use_cassette 'organizer-create-failure' do
      assert_raises Chiketto::Exception do
        Chiketto::Organizer.create 'organizer.name' => 'Test Organizer'
      end
    end
  end
end
