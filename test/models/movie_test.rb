require "test_helper"

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.new(title: "Example Movie", overview: "This is an example movie.",
                       release_date: "2020-01-01", tmdb_id: 1, poster_path: "example.jpg", runtime: 120)
  end

  test "should be valid" do
    assert @movie.valid?
  end

  test "title should be present" do
    @movie.title = " "
    assert_not @movie.valid?
  end

  test "overview should be present" do
    @movie.overview = " "
    assert_not @movie.valid?
  end

  test "release_date should be present" do
    @movie.release_date = " "
    assert_not @movie.valid?
  end

  test "tmdb_id should be present" do
    @movie.tmdb_id = " "
    assert_not @movie.valid?
  end

  test "tmdb_id should be unique" do
    duplicate_movie = @movie.dup
    @movie.save
    assert_not duplicate_movie.valid?
  end

  test "tmdb_id should be an integer" do
    @movie.tmdb_id = "a"
    assert_not @movie.valid?
  end

  test "release_date should be a date" do
    @movie.release_date = "a"
    assert_not @movie.valid?
  end

  test "runtime should be an integer" do
    @movie.runtime = "a"
    assert_not @movie.valid?
  end

  test "runtime should be greater than 0" do
    @movie.runtime = 0
    assert_not @movie.valid?
  end
end
