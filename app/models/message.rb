class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true, allow_blank: false

  scope :most_recent,  ->(term) { order(created_at: :desc).limit(term).reverse }
end
