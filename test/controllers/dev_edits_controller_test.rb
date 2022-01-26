require "test_helper"

class DevEditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dev_edit = dev_edits(:one)
  end

  test "should get index" do
    get dev_edits_url
    assert_response :success
  end

  test "should get new" do
    get new_dev_edit_url
    assert_response :success
  end

  test "should create dev_edit" do
    assert_difference("DevEdit.count") do
      post dev_edits_url, params: { dev_edit: { accepted_date: @dev_edit.accepted_date, due_date: @dev_edit.due_date, invoice_due_date: @dev_edit.invoice_due_date, invoice_paid_date: @dev_edit.invoice_paid_date, rejected_date: @dev_edit.rejected_date, return_date: @dev_edit.return_date, status: @dev_edit.status, user_id: @dev_edit.user_id } }
    end

    assert_redirected_to dev_edit_url(DevEdit.last)
  end

  test "should show dev_edit" do
    get dev_edit_url(@dev_edit)
    assert_response :success
  end

  test "should get edit" do
    get edit_dev_edit_url(@dev_edit)
    assert_response :success
  end

  test "should update dev_edit" do
    patch dev_edit_url(@dev_edit), params: { dev_edit: { accepted_date: @dev_edit.accepted_date, due_date: @dev_edit.due_date, invoice_due_date: @dev_edit.invoice_due_date, invoice_paid_date: @dev_edit.invoice_paid_date, rejected_date: @dev_edit.rejected_date, return_date: @dev_edit.return_date, status: @dev_edit.status, user_id: @dev_edit.user_id } }
    assert_redirected_to dev_edit_url(@dev_edit)
  end

  test "should destroy dev_edit" do
    assert_difference("DevEdit.count", -1) do
      delete dev_edit_url(@dev_edit)
    end

    assert_redirected_to dev_edits_url
  end
end
