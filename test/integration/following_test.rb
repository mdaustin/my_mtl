require "test_helper"

class Following < ActionDispatch::IntegrationTest
  def setup
    @user = users(:matthew)
    @other = users(:archer)
    log_in_as(@user)
  end
end

class FollowTest < Following 

  test "Should follow a user the standard way" do
    assert_difference "@user.following.count", 1 do
      post relationships_path, params: { followed_id: @other.id }
    end
    assert_redirected_to @other
  end

  test "Should follow a user with hotwire" do
    assert_difference "@user.following.count", 1 do
      post relationships_path(format: :turbo_stream), params: { followed_id: @other.id }
    end
  end
end

class Unfollow < Following
  def setup
    super
    @user.follow(@other)
    @relationship = @user.active_relationships.find_by(followed_id: @other.id)
  end
end

class UnfollowTest < Unfollow
  test "Should unfollow a user the standard way" do
    assert_difference "@user.following.count", -1 do
      delete relationship_path(@relationship)
    end
    assert_response :see_other
  end

  test "Should unfollow a user with hotwire" do
    assert_difference "@user.following.count", -1 do
      delete relationship_path(@relationship, format: :turbo_stream)
    end
  end
end

class FollowingPagesTest < Following
  test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user), text:user.username
    end
  end

  test "followers page" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user), text:user.username
    end
  end
end