require "application_system_test_case"

class PostAuthorsTest < ApplicationSystemTestCase
  setup do
    @post_author = post_authors(:one)
  end

  test "visiting the index" do
    visit post_authors_url
    assert_selector "h1", text: "Post Authors"
  end

  test "creating a Post author" do
    visit post_authors_url
    click_on "New Post Author"

    fill_in "Name", with: @post_author.name
    fill_in "Slug", with: @post_author.slug
    click_on "Create Post author"

    assert_text "Post author was successfully created"
    click_on "Back"
  end

  test "updating a Post author" do
    visit post_authors_url
    click_on "Edit", match: :first

    fill_in "Name", with: @post_author.name
    fill_in "Slug", with: @post_author.slug
    click_on "Update Post author"

    assert_text "Post author was successfully updated"
    click_on "Back"
  end

  test "destroying a Post author" do
    visit post_authors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post author was successfully destroyed"
  end
end
