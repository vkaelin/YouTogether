class Room < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages
  belongs_to :user

  validates :name, presence: true, length: { maximum: 15 }

  scope :search,  ->(search_term) { where('name LIKE ?', "%#{search_term}%") }

  paginates_per 9
end
