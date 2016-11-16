require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'computers')
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  test 'name should be present' do
    @category.name = ' '
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save
    category_2 = Category.new(name: 'computers')
    assert_not category_2.valid?
  end

  test 'name should not be too long' do
    @category.name = 'a' * 29
    assert_not @category.valid?
  end

  test 'name should not be too short' do
    @category.name = 'aa'
    assert_not @category.valid?
  end
end
