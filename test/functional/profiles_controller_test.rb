require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  
  test "should get show" do
    get :show, id: users(:mitch).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test "if profile name not found, will return a 'not found' page" do
	get :show, id: 'doesnt exist'
	assert_response :not_found
  end

  test "that variables are assigned on succesful profile viewing" do
    get :show, id: users(:mitch).profile_name
    assert assigns(:user)
    assert_not_empty assigns(:statuses)
  end

  test "only the correct statuses are shown on a user" do
  	get :show, id: users(:mitch).profile_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:mitch), status.user
  	end
  end

end
