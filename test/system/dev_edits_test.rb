require "application_system_test_case"

class DevEditsTest < ApplicationSystemTestCase
  setup do
    @dev_edit = dev_edits(:one)
  end

  test "visiting the index" do
    visit dev_edits_url
    assert_selector "h1", text: "Dev edits"
  end

  test "should create dev edit" do
    visit dev_edits_url
    click_on "New dev edit"

    fill_in "Accepted date", with: @dev_edit.accepted_date
    fill_in "Due date", with: @dev_edit.due_date
    fill_in "Invoice due date", with: @dev_edit.invoice_due_date
    fill_in "Invoice paid date", with: @dev_edit.invoice_paid_date
    fill_in "Rejected date", with: @dev_edit.rejected_date
    fill_in "Return date", with: @dev_edit.return_date
    fill_in "Status", with: @dev_edit.status
    fill_in "User", with: @dev_edit.user_id
    click_on "Create Dev edit"

    assert_text "Dev edit was successfully created"
    click_on "Back"
  end

  test "should update Dev edit" do
    visit dev_edit_url(@dev_edit)
    click_on "Edit this dev edit", match: :first

    fill_in "Accepted date", with: @dev_edit.accepted_date
    fill_in "Due date", with: @dev_edit.due_date
    fill_in "Invoice due date", with: @dev_edit.invoice_due_date
    fill_in "Invoice paid date", with: @dev_edit.invoice_paid_date
    fill_in "Rejected date", with: @dev_edit.rejected_date
    fill_in "Return date", with: @dev_edit.return_date
    fill_in "Status", with: @dev_edit.status
    fill_in "User", with: @dev_edit.user_id
    click_on "Update Dev edit"

    assert_text "Dev edit was successfully updated"
    click_on "Back"
  end

  test "should destroy Dev edit" do
    visit dev_edit_url(@dev_edit)
    click_on "Destroy this dev edit", match: :first

    assert_text "Dev edit was successfully destroyed"
  end
end
