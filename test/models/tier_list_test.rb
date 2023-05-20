require "test_helper"

class TierListTest < ActiveSupport::TestCase
  def setup
    @user = users(:matthew)
    @tier_list = TierList.new(title: "Lorem ipsum", user_id: @user.id)
    @tier_list = @user.tier_lists.build(title: "Lorem ipsum", description: "#{@user.username}'s Movie Tier List")
  end

  test "should be valid" do
    assert @tier_list.valid?
  end

  test "user id should be present" do
    @tier_list.user_id = nil
    assert_not @tier_list.valid?
  end

  test "title should be present" do 
    @tier_list.title = nil
    assert_not @tier_list.valid?
  end

  test "description should be present" do 
    @tier_list.description = nil
    assert_not @tier_list.valid?
  end

  test "should count movies on tier list" do
    tier_list = tier_lists(:mymtl)
    assert_equal tier_list.total_movie_count, 2

  end

end
