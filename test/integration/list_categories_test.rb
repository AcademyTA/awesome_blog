require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category  = Category.create(name: 'movies')
    @category2 = Category.create(name: 'tv shows')
  end

  test 'should show categories listing' do
    # go to categories index
    get categories_path
    # render the categories index template
    assert_template 'categories/index'
    # the categories are present on the index
    # ensure it is linking to the right category
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
  end
end
