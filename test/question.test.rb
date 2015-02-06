require 'test_helper'

class QuestionTest < MiniTest::Test
  def setup
    @question = Chiketto::Question.new 'question' => {
        'text' => 'test question',
        'html' => '<p>test question</p>'
      },
      'id' => '123456',
      'type' => 'checkbox',
      'required' => true,
      'respondent' => 'attendee'
  end

  def test_responds_to_methods
    assert_respond_to @question, :question
    assert_respond_to @question, :type
    assert_respond_to @question, :required
    assert_respond_to @question, :respondent
    assert_respond_to @question, :id
  end

  def test_answer_is_an_attribute
    assert_respond_to @question.answer, :html
    assert_respond_to @question.answer, :text
  end

  def test_required_is_boolean
    assert_kind_of TrueClass, @question.required
  end
end
