require "test_helper"

class TierMoviesControllerTest < ActionDispatch::IntegrationTest
    def setup
        @tier_movie = tier_movies(:one)
    end

    test "should delete tier movie" do
        assert_difference('TierMovie.count', -1) do
            delete user_tier_list_tier_tier_movie_path(@tier_movie.tier.tier_list.user,
                                                       @tier_movie.tier.tier_list,
                                                       @tier_movie.tier,
                                                       @tier_movie)
        end
        assert_redirected_to user_tier_list_path(:id => @tier_movie.tier.tier_list)
    end

    test "should update row order position" do
        put sort_user_tier_list_tier_tier_movie_path(@tier_movie.tier.tier_list.user,
                                                     @tier_movie.tier.tier_list,  
                                                     @tier_movie.tier,
                                                     @tier_movie),
                                                    params: { row_order_position: 4, new_tier_id: @tier_movie.tier.id }
        assert_response :no_content
    end

    test "should update tier" do
        old_tier = @tier_movie.tier
        put sort_user_tier_list_tier_tier_movie_path(@tier_movie.tier.tier_list.user,
                                                     @tier_movie.tier.tier_list,  
                                                     @tier_movie.tier,
                                                     @tier_movie),
                                                    params: { row_order_position: 4, new_tier_id: tiers(:two).id }
        assert_response :no_content
        assert_not_equal old_tier, @tier_movie.reload.tier
    end


end
