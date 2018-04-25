require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'sports')
  end

  test 'category should be valid' do
    assert @category.valid?
  end
  #this tests if instance variable @category is valid. 
  # In order for it to be valid there must be a model and corresponding table in our app

  test 'name should be present' do
    @category.name = ''
    assert_not @category.valid?
  end
  #this tests if an empty string is a valid name for @category instance var
  #In order for the test to find @category not valid there must already be a validation in our app

  test 'name must be unique' do
  	@category.save
  	category2 = Category.new(name: 'sports')
  	assert_not category2.valid?
  		#this assertion expects a false or nil
  end

  test 'name should not be too long' do
  	@category.name = 'a' * 26
  	assert_not @category.valid? 
  end

  test 'name should not be too short' do
  	@category.name = 'aa'
  	assert_not @category.valid? 
  end

end