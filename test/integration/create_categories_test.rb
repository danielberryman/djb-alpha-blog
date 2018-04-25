require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test 'get new category form and create category' do
    #mimic the user actions steps
    #need the path/url to the create new category form (route)
    get new_category_path
    #need the template/form (controller/view)
    assert_template 'categories/new'
    #creating an instance of category and then display it
    #we have no category instances to start but when we create one...
    #...there will be a difference in the category count of 1 when we do the following action:
    assert_difference 'Category.count', 1 do
      #send post request to the categories_path (via redirect) with these attibutes/values
      post_via_redirect categories_path, category: {name: 'sports'}
    end
    #after the post action we want to send the user to categories listing page
    assert_template 'categories/index'
    #ensure the category name is displayed and that's it's dispalyed in the html body tag
    assert_match 'sports', response.body
  end

  test 'invalid category submission results in failure' do
  	#mimic the user actions steps
    #need the path/url to the create new category form (route)
    get new_category_path
    #need the template/form (controller/view)
    assert_template 'categories/new'
    #creating an instance of category and then display it
    #we have no category instances to start but when we create one...
    #...there will be a difference in the category count of 1 when we do the following action:
    assert_no_difference 'Category.count' do
      #send post request to the categories_path (via redirect) with these attibutes/values
      post_via_redirect categories_path, category: {name: ' '}
    end
    #after the post action we want to send the user to categories listing page
    assert_template 'categories/new'
    #ensure the category name is displayed and that's it's dispalyed in the html body tag
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end