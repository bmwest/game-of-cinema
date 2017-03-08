class Review < ApplicationRecord
  validates :body, presence: true
  validates :user_id, presence: true
  validates :theater_id, presence: true

  belongs_to :user
  belongs_to :theater
end
