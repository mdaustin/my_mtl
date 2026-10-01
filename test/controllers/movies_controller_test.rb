require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:matthew)
    @tier_list = tier_lists(:mymtl)
  end

  test "should return search results" do
    skip "Requires a TMDB API key (credentials or TMDB_API_KEY)" if Tmdb::Api.params[:api_key].blank?
    get search_movies_path(@user, @tier_list), params: { query: "The Dark Knight" }
    assert_response :success
    assert @tier_list.search_results_tier.movies.count > 0
  end
  
end
