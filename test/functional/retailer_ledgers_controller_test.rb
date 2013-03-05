require 'test_helper'

class RetailerLedgersControllerTest < ActionController::TestCase
  setup do
    @retailer_ledger = retailer_ledgers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:retailer_ledgers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create retailer_ledger" do
    assert_difference('RetailerLedger.count') do
      post :create, retailer_ledger: @retailer_ledger.attributes
    end

    assert_redirected_to retailer_ledger_path(assigns(:retailer_ledger))
  end

  test "should show retailer_ledger" do
    get :show, id: @retailer_ledger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @retailer_ledger
    assert_response :success
  end

  test "should update retailer_ledger" do
    put :update, id: @retailer_ledger, retailer_ledger: @retailer_ledger.attributes
    assert_redirected_to retailer_ledger_path(assigns(:retailer_ledger))
  end

  test "should destroy retailer_ledger" do
    assert_difference('RetailerLedger.count', -1) do
      delete :destroy, id: @retailer_ledger
    end

    assert_redirected_to retailer_ledgers_path
  end
end
