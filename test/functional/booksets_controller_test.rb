require 'test_helper'

class BooksetsControllerTest < ActionController::TestCase
  setup do
    @bookset = booksets(:novel)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:booksets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookset" do
    assert_difference('Bookset.count') do
      post :create, bookset: @bookset.attributes
    end

    assert_redirected_to bookset_path(assigns(:bookset))
  end

  test "should show bookset" do
    get :show, id: @bookset.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookset.to_param
    assert_response :success
  end

  test "should update bookset" do
    put :update, id: @bookset.to_param, bookset: @bookset.attributes
    assert_redirected_to bookset_path(assigns(:bookset))
  end

  test "should destroy bookset" do
    assert_difference('Bookset.count', -1) do
      delete :destroy, id: @bookset.to_param
    end

    assert_redirected_to booksets_path
  end
end
