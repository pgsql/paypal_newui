require 'test_helper'

class CalculatorsControllerTest < ActionController::TestCase
  setup do
    @calculator = calculators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calculators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calculator" do
    assert_difference('Calculators.count') do
      post :create, :calculator => @calculator.attributes
    end

    assert_redirected_to calculator_path(assigns(:calculator))
  end

  test "should show calculator" do
    get :show, :id => @calculator.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @calculator.to_param
    assert_response :success
  end

  test "should update calculator" do
    put :update, :id => @calculator.to_param, :calculator => @calculator.attributes
    assert_redirected_to calculator_path(assigns(:calculator))
  end

  test "should destroy calculator" do
    assert_difference('Calculators.count', -1) do
      delete :destroy, :id => @calculator.to_param
    end

    assert_redirected_to calculators_index_path
  end
end
