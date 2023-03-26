require "test_helper"

class TierMoviesControllerTest < ActionDispatch::IntegrationTest

    test "should delete tier movie" do
        tier_movie = tier_movies(:one)
        assert_difference('TierMovie.count', -1) do
            delete user_tier_list_tier_tier_movie_path(tier_movie.tier.tier_list.user,
                                                       tier_movie.tier.tier_list,
                                                       tier_movie.tier,
                                                       tier_movie)
        end
        assert_redirected_to user_tier_list_path(:id => tier_movie.tier.tier_list)
    end
end
