require "test_helper"

class TierMovieTest < ActiveSupport::TestCase
  def setup
    @tier = tiers(:two)
    @movie = movies(:batman)
    @tier_movie = TierMovie.new(tier_id: @tier.id, movie_id: @movie.id, row_order: 1)
  end

  test "should be valid" do
    assert @tier_movie.valid?
  end

  test "tier_id should be present" do
    @tier_movie.tier_id = " "
    assert_not @tier_movie.valid?
  end

  test "movie_id should be present" do
    @tier_movie.movie_id = " "
    assert_not @tier_movie.valid?
  end

  test "tier_id should be an integer" do
    @tier_movie.tier_id = "a"
    assert_not @tier_movie.valid?
  end

  test "movie_id should be an integer" do
    @tier_movie.movie_id = "a"
    assert_not @tier_movie.valid?
  end

  test "movie_id should be unique per tier" do
    duplicate_tier_movie = @tier_movie.dup
    @tier_movie.save
    assert_not duplicate_tier_movie.valid?
  end
end
