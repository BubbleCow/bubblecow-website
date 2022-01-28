require "application_system_test_case"

class DevEditSamplesTest < ApplicationSystemTestCase
  setup do
    @dev_edit_sample = dev_edit_samples(:one)
  end

  test "visiting the index" do
    visit dev_edit_samples_url
    assert_selector "h1", text: "Dev edit samples"
  end

  test "should create dev edit sample" do
    visit dev_edit_samples_url
    click_on "New dev edit sample"

    fill_in "Book", with: @dev_edit_sample.book_id
    click_on "Create Dev edit sample"

    assert_text "Dev edit sample was successfully created"
    click_on "Back"
  end

  test "should update Dev edit sample" do
    visit dev_edit_sample_url(@dev_edit_sample)
    click_on "Edit this dev edit sample", match: :first

    fill_in "Book", with: @dev_edit_sample.book_id
    click_on "Update Dev edit sample"

    assert_text "Dev edit sample was successfully updated"
    click_on "Back"
  end

  test "should destroy Dev edit sample" do
    visit dev_edit_sample_url(@dev_edit_sample)
    click_on "Destroy this dev edit sample", match: :first

    assert_text "Dev edit sample was successfully destroyed"
  end
end
