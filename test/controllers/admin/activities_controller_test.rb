require 'test_helper'

class Admin::ActivitiesControllerTest < ActionController::TestCase
  setup do
    @admin_activity = admin_activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_activity" do
    assert_difference('Admin::Activity.count') do
      post :create, admin_activity: {  }
    end

    assert_redirected_to admin_activity_path(assigns(:admin_activity))
  end

  test "should show admin_activity" do
    get :show, id: @admin_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_activity
    assert_response :success
  end

  test "should update admin_activity" do
    patch :update, id: @admin_activity, admin_activity: {  }
    assert_redirected_to admin_activity_path(assigns(:admin_activity))
  end

  test "should destroy admin_activity" do
    assert_difference('Admin::Activity.count', -1) do
      delete :destroy, id: @admin_activity
    end

    assert_redirected_to admin_activities_path
  end
end
