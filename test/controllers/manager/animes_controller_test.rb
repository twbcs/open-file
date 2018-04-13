require 'test_helper'

class Manager::AnimesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_animes_index_url
    assert_response :success
  end

  test "should get show" do
    get manager_animes_show_url
    assert_response :success
  end

  test "should get edit" do
    get manager_animes_edit_url
    assert_response :success
  end

  test "should get new" do
    get manager_animes_new_url
    assert_response :success
  end

end
