require 'test_helper'

class OrganizerTest < MiniTest::Test
  def setup
    @organizer = Chiketto::Organizer.new({
      'description' => {
        'text' => 'Description of the Example Organizer', 
        'html' => '<p>Description of the Example Organizer</p>'
      }, 
      'id' => '1667263718', 
      'name' => 'Example Organizer'
    })
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
end
