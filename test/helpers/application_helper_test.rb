require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test "full title helper" do
      # Проверка базового заголовка
      assert_equal full_title, "Ruby on Rails Tutorial Sample App"
      # Проверка заголовка с дополнением
      assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
    end
  end