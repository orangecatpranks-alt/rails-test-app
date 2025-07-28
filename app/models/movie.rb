class Movie < ApplicationRecord
  # Associations
  has_many :watchlists, dependent: :destroy
  has_many :users, through: :watchlists

  # Validations
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :release_year,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1888,
      less_than_or_equal_to: Date.current.year + 5
    },
    allow_nil: true
end
