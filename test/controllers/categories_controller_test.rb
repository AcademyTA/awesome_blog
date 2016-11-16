require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: 'comedy')
  end

  test 'should show categories index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get show' do
    get :show, id: @category.id
    assert_response :success
  end
end
