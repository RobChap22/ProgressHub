class Review < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :content, presence: true
  validates :rating, presence: true
  has_one_attached :photo
end
