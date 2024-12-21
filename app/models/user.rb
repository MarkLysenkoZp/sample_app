class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true # Validation: the "name" field must be filled in (cannot be empty)
  validates :email, presence: true # Validation: the "email" field must be filled in (cannot be empty)


  validates :name,  presence: true, length: { maximum: 50 } # Ensures 'name' is present and ≤ 50 chars.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # Email format validation regex.
  validates :email, presence: true, length: { maximum: 255 }, # Ensures 'email' is present, ≤ 255 chars.
                    format: { with: VALID_EMAIL_REGEX }, # Checks 'email' matches the regex format.  
                    uniqueness: { case_sensitive: false } # Ensure uniqueness of email, ignoring case.
                    has_secure_password                   
end
