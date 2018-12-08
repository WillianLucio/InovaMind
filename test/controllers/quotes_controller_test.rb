require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get quotes_search_url
    assert_response :success
  end

end
