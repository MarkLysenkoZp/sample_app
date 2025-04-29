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

  test "layout links for non-logged-in user" do
    get root_path
    assert_template 'static_pages/home'

    # Checking for links in the header and footer
    assert_select "a[href=?]", root_path, count: 2 # "Home" logo and link
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path

    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "layout links for logged-in user" do
    log_in_as(@user)  # Use the helper to log in
    get root_path

    # Check that the standard links are present
    assert_select "a[href=?]", root_path, count: 2  
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end