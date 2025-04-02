require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                          email: "foo@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    assert_template 'users/edit'
  end


  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,  
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end


  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)

    # Check that the forwarding URL is saved (indirectly via redirect)
    assert_equal edit_user_url(@user), session[:forwarding_url] rescue nil

    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email

    # Check that the forwarding URL is no longer saved (indirectly via re-entry)
    log_in_as(@user)
    assert_redirected_to @user
  end
end