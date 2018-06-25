class FavoriteVideo < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, allow_blank: false

  paginates_per 6
end
