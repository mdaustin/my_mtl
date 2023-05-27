require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
    @user = User.new(username: "exampleUser", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid? 
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "should follow and unfollow a user" do
    user = users(:matthew)
    other_user = users(:archer)
    assert_not user.following?(other_user)
    user.follow(other_user)
    assert user.following?(other_user)
    assert other_user.followers.include?(user)
    user.unfollow(other_user)
    assert_not user.following?(other_user)

    # Users can't follow themselves
    user.follow(user)
    assert_not user.following?(user)
  end

  test "should count number of ranked movies" do 
    user = users(:matthew)
    assert_equal user.total_ranked_movie_count, 2
  end

  test "feed should have the right tier_lists" do
    matthew = users(:matthew)
    archer = users(:archer)
    lana = users(:lana)
    # Tier lists from followed user
    lana.tier_lists.each do |tier_list_following|
      assert matthew.feed.include?(tier_list_following)
    end

    # Tier lists from self
    matthew.tier_lists.each do |tier_list_self|
      assert matthew.feed.include?(tier_list_self)
    end

    # Tier lists from unfollowed user
    archer.tier_lists.each do |tier_list_unfollowed|
      assert_not matthew.feed.include?(tier_list_unfollowed)
    end
  end

  test "should search users by username" do
    matthew = users(:matthew)
    archer = users(:archer)
    lana = users(:lana)

    assert_equal User.search("matthew"), [matthew]
    assert_equal User.search("archer"), [archer]
    assert_equal User.search("lana"), [lana]
    assert_equal User.search(""), User.all
  end
end
