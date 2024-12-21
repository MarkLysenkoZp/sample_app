require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  

    test "should be valid" do # Verifies that a user with valid attributes is considered valid.
      assert @user.valid?
    end
    
    test "name should be present" do # Checks that a user with an empty name is invalid.
      @user.name = ""
      assert_not @user.valid?
    end
    
    test "email should be present" do # Ensures that a user with only whitespace in the email field is invalid.
      @user.email = "    "
      assert_not @user.valid?
    end
    
    test "name should not be too long" do # Validates that a name longer than 50 characters is considered invalid.
      @user.name = "a" * 51
      assert_not @user.valid?
    end
    
    test "email should not be too long" do # Confirms that an email exceeding 255 characters is considered invalid.
      @user.email = "a" * 244 + "@example.com"
      assert_not @user.valid?
    end
    
    test "email validation should accept valid addresses" do # Ensures that valid email addresses are considered valid.
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid" # Outputs a message if the email is incorrectly marked as invalid.
      end
    end
    
    test "email validation should reject invalid addresses" do # Ensures that invalid email addresses are considered invalid.
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid" # Outputs a message if the email is incorrectly marked as valid.
      end
    end

    test "email addresses should be unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      assert_not duplicate_user.valid?
    end
     
end
