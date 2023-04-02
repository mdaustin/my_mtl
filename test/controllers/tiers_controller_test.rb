require "test_helper"

class TiersControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:matthew)
    @tier_list = tier_lists(:mymtl)
    @tier = tiers(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Tier.count' do
      post user_tier_list_tiers_path(@tier_list.user, @tier_list), params: { tier: { title: "Test Tier" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Tier.count' do
      delete user_tier_list_tier_path(@tier_list.user, @tier_list, @tier)
    end
    assert_redirected_to login_url
  end

  test "should redirect create when logged in as wrong user" do
    log_in_as(users(:lana))
    assert_no_difference 'Tier.count' do
      post user_tier_list_tiers_path(@tier_list.user, @tier_list), params: { tier: { title: "Test Tier" } }
    end
    assert_redirected_to users(:lana)    #NOTE: This should probably redirect to the user they were trying to access
  end

  test "should redirect destroy when logged in as wrong user" do
    log_in_as(users(:lana))
    assert_no_difference 'Tier.count' do
      delete user_tier_list_tier_path(@tier_list.user, @tier_list, @tier)
    end
    assert_redirected_to users(:lana)    #NOTE: This should probably redirect to the user they were trying to access
  end


  test "should redirect destroy when logged in as correct user but wrong tier list" do
    log_in_as(@user)
    assert_no_difference 'Tier.count' do
      delete user_tier_list_tier_path(@user, tier_lists(:testmtl), @tier)
    end
    assert_redirected_to @user
  end

  test "should create tier when logged in as correct user" do
    log_in_as(@user)
    assert_difference 'Tier.count', 1 do
      post user_tier_list_tiers_path(@user, @tier_list), params: { tier: { title: "Test Tier" } }
    end
    assert_redirected_to user_tier_list_path(@tier_list.user, @tier_list)
  end

  test "should destroy tier when logged in as correct user" do
    log_in_as(@user)
    assert_difference 'Tier.count', -1 do
      delete user_tier_list_tier_path(@user, @tier_list, @tier)
    end
    assert_redirected_to user_tier_list_path(@tier_list.user, @tier_list)
  end
end
