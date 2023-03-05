require "test_helper"

class UsersIndex < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:matthew)
    @non_admin = users(:archer)
  end
end

class UsersIndexAdmin < UsersIndex
  def setup
    super
    log_in_as(@admin)
    get users_path
  end
end

class UsersIndexAdminTest < UsersIndexAdmin
  test "should render the index page" do
    assert_template 'users/index'
  end

  test "should paginate users" do
    assert_select 'div.pagination', count: 1
  end

  test "should have delete links" do
    first_page_of_users = User.paginate(page:1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.username
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
  end

  test "shpuld be able to delete non-admin user" do
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
      assert_response :see_other
      assert_redirected_to users_url
    end
  end


end

class UsersNonAdminIndexTest < UsersIndex
  test "should not have delete links as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    assert_select 'a', text: 'delete', count: 0
  end
end