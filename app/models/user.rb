class User < ApplicationRecord
  # Enable secure password functionality using bcrypt
  has_secure_password

  # Associations
  has_many :watchlists, dependent: :destroy
  has_many :movies, through: :watchlists

  # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  # Only for creating a new record or updating password
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  # Normalize username before saving
  before_save :normalize_username

  private

  # Convert username to lowercase and remove whitespace
  def normalize_username
    self.username = username.downcase.strip
  end
end
