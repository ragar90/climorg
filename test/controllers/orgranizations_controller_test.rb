require 'test_helper'

class OrgranizationsControllerTest < ActionController::TestCase
  setup do
    @orgranization = orgranizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orgranizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orgranization" do
    assert_difference('Orgranization.count') do
      post :create, orgranization: { country_id: @orgranization.country_id, name: @orgranization.name }
    end

    assert_redirected_to orgranization_path(assigns(:orgranization))
  end

  test "should show orgranization" do
    get :show, id: @orgranization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @orgranization
    assert_response :success
  end

  test "should update orgranization" do
    patch :update, id: @orgranization, orgranization: { country_id: @orgranization.country_id, name: @orgranization.name }
    assert_redirected_to orgranization_path(assigns(:orgranization))
  end

  test "should destroy orgranization" do
    assert_difference('Orgranization.count', -1) do
      delete :destroy, id: @orgranization
    end

    assert_redirected_to orgranizations_path
  end
end
