require 'test_helper'

class PostAuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_author = post_authors(:one)
  end

  test "should get index" do
    get post_authors_url
    assert_response :success
  end

  test "should get new" do
    get new_post_author_url
    assert_response :success
  end

  test "should create post_author" do
    assert_difference('PostAuthor.count') do
      post post_authors_url, params: { post_author: { name: @post_author.name, slug: @post_author.slug } }
    end

    assert_redirected_to post_author_url(PostAuthor.last)
  end

  test "should show post_author" do
    get post_author_url(@post_author)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_author_url(@post_author)
    assert_response :success
  end

  test "should update post_author" do
    patch post_author_url(@post_author), params: { post_author: { name: @post_author.name, slug: @post_author.slug } }
    assert_redirected_to post_author_url(@post_author)
  end

  test "should destroy post_author" do
    assert_difference('PostAuthor.count', -1) do
      delete post_author_url(@post_author)
    end

    assert_redirected_to post_authors_url
  end
end
