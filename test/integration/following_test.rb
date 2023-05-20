require "test_helper"

class Following < ActionDispatch::IntegrationTest
  def setup
    @user = users(:matthew)
    @other = users(:archer)
    log_in_as(@user)
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