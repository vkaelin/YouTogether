class Room < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :name, length: { maximum: 30 }

  scope :search,  ->(search_term) { where('name LIKE ?', "%#{search_term}%") }
end
