class Room < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages

  validates :name, presence: true
  validates :name, length: { maximum: 20 }

  scope :search,  ->(search_term) { where('name LIKE ?', "%#{search_term}%") }

  paginates_per 9
end
