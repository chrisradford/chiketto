require 'test_helper'

class AttributeTest < MiniTest::Test
  def setup
    @attrib = Chiketto::Attribute.new({ 'text' => 'Test', 'html' => '<p>Test</p>' })
  end

  def test_attribute_accepts_and_returns_values
    assert_respond_to @attrib, :text
    assert_respond_to @attrib, :html
    assert_equal 'Test', @attrib.text
    assert_equal '<p>Test</p>', @attrib.html
  end

  def test_attribute_responds_to_s
    assert_respond_to @attrib, :to_s
    assert_equal 'Test', @attrib.to_s
    assert_equal 'Test', "#{@attrib}"
  end
end
