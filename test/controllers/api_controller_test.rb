require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get api_news_url
    assert_response :success
  end

  test "should get new" do
    get api_new_url
    assert_response :success
  end

  test "should get fecha" do
    get api_fecha_url
    assert_response :success
  end

end
