require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "a user should be redirected to login when they try to 
        post a status not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render a new page when logged in" do
    sign_in users(:mitch)
    get :new
    assert_response :success
  end

  test "user needs to be signed-in in order to post a status" do
    post :create, status: { content:"hello" }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create status when logged in" do
    sign_in users(:mitch)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should create status for the current user when logged in" do
    sign_in users(:mitch)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:ryan).id }
    end

    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:mitch).id
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should get edit when logged in" do
    sign_in users(:mitch)
    get :edit, id: @status 
    assert_response :success
  end

  test "should update status" do
    sign_in users(:mitch)
    put :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should update status for current user when logged in" do
    sign_in users(:mitch)
    put :update, id: @status, status: { content: @status.content, user_id: users(:ryan).id  }
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:mitch).id
  end

  test "should not update status is nothing has changed" do
    sign_in users(:mitch)
    put :update, id: @status
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:mitch).id
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
  
end
