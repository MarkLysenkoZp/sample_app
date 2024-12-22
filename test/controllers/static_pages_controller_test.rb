require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase


  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"  # Initializes a base title variable for consistent use in title-related tests.
  end  

  test "should get home" do
    get :home
    assert_response :success

    # Checks if the <title> tag in the HTML response contains the expected text "Home | #{@base_title}"
    # Ensures that the page title is correctly set for the home page
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base_title}" 
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{@base_title}" 

  end

  test "should get contact" do   # Tests the 'contact' action. Ensures a successful response. Verifies the page title is correct.
    get :contact
    assert_response :success
    assert_select "title", "Contact | #{@base_title}" #
  end
end