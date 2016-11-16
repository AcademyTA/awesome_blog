require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test 'get new category form and create category' do
    # go to new category path
    get new_category_path
    # make sure we render the new categor template
    assert_template 'categories/new'
    # create a new category and make sure the count increments
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: { name: 'movies' }
    end
    # after creation we are redirected to the categories index
    assert_template 'categories/index'
    # expect the categories index to contain the String 'movies'
    assert_match 'movies', response.body
  end

  test 'invalid category submission results in failure' do
    # go to new category path
    get new_category_path
    # make sure we render the new categor template
    assert_template 'categories/new'
    # the count does not change
    assert_no_difference 'Category.count' do
      post categories_path, category: { name: ' ' }
    end
    # re-renders the new template
    assert_template 'categories/new'
    # assert the template contains the title and body from the errors partial
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
