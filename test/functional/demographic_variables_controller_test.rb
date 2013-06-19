require 'test_helper'

class DemographicVariablesControllerTest < ActionController::TestCase
  setup do
    @demographic_variable = demographic_variables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:demographic_variables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create demographic_variable" do
    assert_difference('DemographicVariable.count') do
      post :create, demographic_variable: { demographic_type_id: @demographic_variable.demographic_type_id, display_values: @demographic_variable.display_values, is_default: @demographic_variable.is_default, name: @demographic_variable.name }
    end

    assert_redirected_to demographic_variable_path(assigns(:demographic_variable))
  end

  test "should show demographic_variable" do
    get :show, id: @demographic_variable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @demographic_variable
    assert_response :success
  end

  test "should update demographic_variable" do
    put :update, id: @demographic_variable, demographic_variable: { demographic_type_id: @demographic_variable.demographic_type_id, display_values: @demographic_variable.display_values, is_default: @demographic_variable.is_default, name: @demographic_variable.name }
    assert_redirected_to demographic_variable_path(assigns(:demographic_variable))
  end

  test "should destroy demographic_variable" do
    assert_difference('DemographicVariable.count', -1) do
      delete :destroy, id: @demographic_variable
    end

    assert_redirected_to demographic_variables_path
  end
end
