require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test "full title helper" do
      # Base header check
      assert_equal full_title, "Ruby on Rails Tutorial Sample App"
      # Header check with padding
      assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
    end
  end