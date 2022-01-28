require "test_helper"

class DevEditSamplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dev_edit_sample = dev_edit_samples(:one)
  end

  test "should get index" do
    get dev_edit_samples_url
    assert_response :success
  end

  test "should get new" do
    get new_dev_edit_sample_url
    assert_response :success
  end

  test "should create dev_edit_sample" do
    assert_difference("DevEditSample.count") do
      post dev_edit_samples_url, params: { dev_edit_sample: { book_id: @dev_edit_sample.book_id } }
    end

    assert_redirected_to dev_edit_sample_url(DevEditSample.last)
  end

  test "should show dev_edit_sample" do
    get dev_edit_sample_url(@dev_edit_sample)
    assert_response :success
  end

  test "should get edit" do
    get edit_dev_edit_sample_url(@dev_edit_sample)
    assert_response :success
  end

  test "should update dev_edit_sample" do
    patch dev_edit_sample_url(@dev_edit_sample), params: { dev_edit_sample: { book_id: @dev_edit_sample.book_id } }
    assert_redirected_to dev_edit_sample_url(@dev_edit_sample)
  end

  test "should destroy dev_edit_sample" do
    assert_difference("DevEditSample.count", -1) do
      delete dev_edit_sample_url(@dev_edit_sample)
    end

    assert_redirected_to dev_edit_samples_url
  end
end
