require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:matthew)
    @tier_list = tier_lists(:mymtl)
  end

  test "should return search results" do
    get search_movies_path(@user, @tier_list), params: { query: "The Dark Knight" }
    assert_response :success
  end
  
end
