require 'test_helper'

class DemographicTypesControllerTest < ActionController::TestCase
  setup do
    @demographic_type = demographic_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:demographic_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create demographic_type" do
    assert_difference('DemographicType.count') do
      post :create, demographic_type: { acsepted_values: @demographic_type.acsepted_values, name: @demographic_type.name }
    end

    assert_redirected_to demographic_type_path(assigns(:demographic_type))
  end

  test "should show demographic_type" do
    get :show, id: @demographic_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @demographic_type
    assert_response :success
  end

  test "should update demographic_type" do
    put :update, id: @demographic_type, demographic_type: { acsepted_values: @demographic_type.acsepted_values, name: @demographic_type.name }
    assert_redirected_to demographic_type_path(assigns(:demographic_type))
  end

  test "should destroy demographic_type" do
    assert_difference('DemographicType.count', -1) do
      delete :destroy, id: @demographic_type
    end

    assert_redirected_to demographic_types_path
  end
end
