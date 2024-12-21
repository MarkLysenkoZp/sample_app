require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path

    get signup_path # Sends an HTTP GET request to the "signup" path, simulating a user navigating to the signup page
    assert_select "title", full_title("Sign up")  # Checks if the page title contains "Sign up" by calling the full_title helper

  end
end
