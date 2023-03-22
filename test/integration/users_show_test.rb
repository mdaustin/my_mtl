require "test_helper"

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup 
    @inactive_user = users(:inactive)
    @active_user = users(:archer)
  end

  test "should redirect when user not activated" do 
    get user_path(@inactive_user)
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should display user when activated" do
    get user_path(@active_user)
    assert_response :success
    assert_template 'users/show'
  end

  test "should show tier_lists on user page" do
    get user_path(@active_user)
    assert_select 'a[href=?]', user_tier_list_path(@active_user, @active_user.tier_lists.first)
  end
end
