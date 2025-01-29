require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                   email: "user@invalid",
                                   password:              "foo",
                                   password_confirmation: "bar" } }
    end
    assert_template 'users/new'

    
    # checking the display of form validation errors
    assert_select 'li', "Name can't be blank"
    assert_select 'li', "Email is invalid"
    assert_select 'li', "Password is too short (minimum is 6 characters)"
    assert_select 'li', "Password confirmation doesn't match Password"
  end


  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
      follow_redirect!
    end
    assert_template 'users/show'
  end
end