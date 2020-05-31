require 'test_helper'

class DevelopmentalEditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @developmental_edit = developmental_edits(:one)
  end

  test "should get index" do
    get developmental_edits_url
    assert_response :success
  end

  test "should get new" do
    get new_developmental_edit_url
    assert_response :success
  end

  test "should create developmental_edit" do
    assert_difference('DevelopmentalEdit.count') do
      post developmental_edits_url, params: { developmental_edit: { slug: @developmental_edit.slug, title: @developmental_edit.title, user_id: @developmental_edit.user_id } }
    end

    assert_redirected_to developmental_edit_url(DevelopmentalEdit.last)
  end

  test "should show developmental_edit" do
    get developmental_edit_url(@developmental_edit)
    assert_response :success
  end

  test "should get edit" do
    get edit_developmental_edit_url(@developmental_edit)
    assert_response :success
  end

  test "should update developmental_edit" do
    patch developmental_edit_url(@developmental_edit), params: { developmental_edit: { slug: @developmental_edit.slug, title: @developmental_edit.title, user_id: @developmental_edit.user_id } }
    assert_redirected_to developmental_edit_url(@developmental_edit)
  end

  test "should destroy developmental_edit" do
    assert_difference('DevelopmentalEdit.count', -1) do
      delete developmental_edit_url(@developmental_edit)
    end

    assert_redirected_to developmental_edits_url
  end
end
