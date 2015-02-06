require 'test_helper'

class ChoiceTest < MiniTest::Test
  def setup
    @choice = Chiketto::Choice.new 'answer' => {
        'text' => 'test choice',
        'html' => '<p>test choice</p>'
      },
      'id' => '123456'
  end

  def test_responds_to_methods
    assert_respond_to @choice, :answer
    assert_respond_to @choice, :id
  end

  def test_answer_is_an_attribute
    assert_respond_to @choice.answer, :html
    assert_respond_to @choice.answer, :text
  end
end
