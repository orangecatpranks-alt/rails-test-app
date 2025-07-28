class Watchlist < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :movie

  # Validations
  validates :user_id, uniqueness: { scope: :movie_id }
end
