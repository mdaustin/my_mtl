require "test_helper"

class TierListsControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:matthew)
    @other_user = users(:archer)
    @tier_list = tier_lists(:mymtl)
  end

  test "should get new when logged in" do
    log_in_as(@user)
    get new_user_tier_list_path(@user)
    assert_response :success
  end

  test "should get edit when logged in" do
    log_in_as(@user)
    get edit_user_tier_list_path(@user, @tier_list)
    assert_response :success
  end

  test "should updated tier list when logged in" do
    log_in_as(@user)
    patch user_tier_list_path(@user, @tier_list), params: { tier_list: { title: "Test", description: "Test" } }
    assert_redirected_to user_tier_lists_path(@tier_list)

    @tier_list.reload
    assert @tier_list.title == "Test"
    assert @tier_list.description == "Test"
  end

  test "should create tier list when logged in" do
    log_in_as(@user)
    assert_difference 'TierList.count', 1 do
      post user_tier_lists_path(@user), params: { tier_list: { title: "Test", description: "Test" } }
    end
    assert_redirected_to @user
  end
  
  test "should destroy tier list when logged in" do
    log_in_as(@user)
    assert_difference 'TierList.count', -1 do
      delete user_tier_list_path(@user, @tier_list)
    end
    assert_redirected_to @user
  end

  test "should redirect new when not logged in" do
    get new_user_tier_list_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'TierList.count' do
      post user_tier_lists_path(@user), params: { tier_list: { title: "Test", description: "Test" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_user_tier_list_path(@user, @tier_list)
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_tier_list_path(@user, @tier_list), params: { tier_list: { title: "Test", description: "Test" } }
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'TierList.count' do
      delete user_tier_list_path(@user, @tier_list)
    end
    assert_redirected_to login_url
  end

  # Mark for skip 
  # test "should redirect new when logged in as wrong user" do
  #   log_in_as(@other_user)
  #   get new_user_tier_list_path(@user)
  #   assert_redirected_to @other_user
  # end 

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_tier_list_path(@user, @tier_list)
    assert flash.empty?
    assert_redirected_to @other_user
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_tier_list_path(@user, @tier_list), params: { tier_list: { title: "Test", description: "Test" } }
    assert flash.empty?
    assert_redirected_to @other_user
  end

  test "should redirect destroy when logged in as wrong user" do
    log_in_as(@other_user)
    assert_no_difference 'TierList.count' do
      delete user_tier_list_path(@user, @tier_list)
    end
    assert_redirected_to @other_user
  end

  test "should redirect destroy for wrong tier list" do
    log_in_as(@user)
    tier_list = tier_lists(:archermtl)
    assert_no_difference 'TierList.count' do
      delete user_tier_list_path(@user, tier_list)
    end
    assert_redirected_to @user
  end
end
