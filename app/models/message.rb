class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true, allow_blank: false
end
