class User < ActiveRecord::Base
  attr_accessor :reset_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  scope :search_by_name, ->(query) {
    where("LOWER(name) LIKE ?", "%#{query.downcase}%") if query.present?
  }

  # -------------------------
  # Методы восстановления пароля

  # Генерация токена
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Хеширование строки
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Сохраняем токен и его хеш
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(
      reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
    )
  end

  # Проверка токена
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Проверка на истечение срока
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # -------------------------
  # Методы для запоминания (remember me)

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

def authenticated?(attribute, token)
  digest = send("#{attribute}_digest")
  return false if digest.nil?
  BCrypt::Password.new(digest).is_password?(token)
end

end
