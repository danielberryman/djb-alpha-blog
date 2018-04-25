require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup 
  	@category = Category.create(name: 'sports')
  	@user = User.create(username: "john", email: "john@mail.com", password: "password", admin: true)
  end

  test 'should get categories index' do
  	get :index
  	assert_response :success
  end

  test 'should get new' do
  	session[:user_id] = @user.id
  	get :new
  	assert_response :success
  end
  
  test 'should get show' do
  	get(:show, {'id' => @category.id})
  	assert_response :success
  end	

  test 'should redirect create when admin not logged in' do
  	#we haven't logged an admin in in our above tests
  	assert_no_difference 'Category.count' do
  	#this means that category.count will not change will be true
  	#to test is any post request for a new item is made use the .count method
  	  post :create, category: { name: 'sports'}
  	  #this is what happens (when this happens does category count change return to be true?)
  	end
  	assert_redirected_to categories_path
  end

end