require "application_system_test_case"

class DevelopmentalEditsTest < ApplicationSystemTestCase
  setup do
    @developmental_edit = developmental_edits(:one)
  end

  test "visiting the index" do
    visit developmental_edits_url
    assert_selector "h1", text: "Developmental Edits"
  end

  test "creating a Developmental edit" do
    visit developmental_edits_url
    click_on "New Developmental Edit"

    fill_in "Slug", with: @developmental_edit.slug
    fill_in "Title", with: @developmental_edit.title
    fill_in "User", with: @developmental_edit.user_id
    click_on "Create Developmental edit"

    assert_text "Developmental edit was successfully created"
    click_on "Back"
  end

  test "updating a Developmental edit" do
    visit developmental_edits_url
    click_on "Edit", match: :first

    fill_in "Slug", with: @developmental_edit.slug
    fill_in "Title", with: @developmental_edit.title
    fill_in "User", with: @developmental_edit.user_id
    click_on "Update Developmental edit"

    assert_text "Developmental edit was successfully updated"
    click_on "Back"
  end

  test "destroying a Developmental edit" do
    visit developmental_edits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Developmental edit was successfully destroyed"
  end
end
