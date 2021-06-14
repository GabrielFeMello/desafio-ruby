require 'test_helper'

class TransationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transation = transations(:one)
  end

  test "should get index" do
    get transations_url
    assert_response :success
  end

  test "should get new" do
    get new_transation_url
    assert_response :success
  end

  test "should create transation" do
    assert_difference('Transation.count') do
      post transations_url, params: { transation: { card: @transation.card, date: @transation.date, representative_id: @transation.representative_id, store_id: @transation.store_id, time: @transation.time, type: @transation.type, value: @transation.value } }
    end

    assert_redirected_to transation_url(Transation.last)
  end

  test "should show transation" do
    get transation_url(@transation)
    assert_response :success
  end

  test "should get edit" do
    get edit_transation_url(@transation)
    assert_response :success
  end

  test "should update transation" do
    patch transation_url(@transation), params: { transation: { card: @transation.card, date: @transation.date, representative_id: @transation.representative_id, store_id: @transation.store_id, time: @transation.time, type: @transation.type, value: @transation.value } }
    assert_redirected_to transation_url(@transation)
  end

  test "should destroy transation" do
    assert_difference('Transation.count', -1) do
      delete transation_url(@transation)
    end

    assert_redirected_to transations_url
  end
end
