require 'test_helper'

class BiannualsControllerTest < ActionController::TestCase
  setup do
    @biannual = biannuals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:biannuals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create biannual" do
    assert_difference('Biannual.count') do
      post :create, biannual: { completed: @biannual.completed, completed_by: @biannual.completed_by, title: @biannual.title }
    end

    assert_redirected_to biannual_path(assigns(:biannual))
  end

  test "should show biannual" do
    get :show, id: @biannual
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @biannual
    assert_response :success
  end

  test "should update biannual" do
    patch :update, id: @biannual, biannual: { completed: @biannual.completed, completed_by: @biannual.completed_by, title: @biannual.title }
    assert_redirected_to biannual_path(assigns(:biannual))
  end

  test "should destroy biannual" do
    assert_difference('Biannual.count', -1) do
      delete :destroy, id: @biannual
    end

    assert_redirected_to biannuals_path
  end
end
