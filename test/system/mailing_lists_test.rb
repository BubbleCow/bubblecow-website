require "application_system_test_case"

class MailingListsTest < ApplicationSystemTestCase
  setup do
    @mailing_list = mailing_lists(:one)
  end

  test "visiting the index" do
    visit mailing_lists_url
    assert_selector "h1", text: "Mailing Lists"
  end

  test "creating a Mailing list" do
    visit mailing_lists_url
    click_on "New Mailing List"

    fill_in "Email", with: @mailing_list.email
    fill_in "Tag", with: @mailing_list.tag
    click_on "Create Mailing list"

    assert_text "Mailing list was successfully created"
    click_on "Back"
  end

  test "updating a Mailing list" do
    visit mailing_lists_url
    click_on "Edit", match: :first

    fill_in "Email", with: @mailing_list.email
    fill_in "Tag", with: @mailing_list.tag
    click_on "Update Mailing list"

    assert_text "Mailing list was successfully updated"
    click_on "Back"
  end

  test "destroying a Mailing list" do
    visit mailing_lists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mailing list was successfully destroyed"
  end
end
