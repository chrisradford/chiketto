require 'test_helper'

class CategoryTest < MiniTest::Test
  def list_categories
    VCR.use_cassette 'catgories' do
      @categories = Chiketto::Category.list
    end
  end

  def test_categories_returns_list
    list_categories
    assert_kind_of Array, @categories
    assert_kind_of Chiketto::Category, @categories.first
  end

  def test_category_responds_to_methods
    list_categories
    @category = @categories.first
    assert_respond_to @category, :id
    assert_respond_to @category, :name
    assert_respond_to @category, :resource_uri
    assert_respond_to @category, :short_name
  end
end
