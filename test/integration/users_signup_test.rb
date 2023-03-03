require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" } }
      end
      assert_response :unprocessable_entity
      assert_template 'users/new'
      assert_select 'div.bg-red-50'
      assert_select 'div.field_with_errors'
  end
end