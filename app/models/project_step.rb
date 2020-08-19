class ProjectStep < ApplicationRecord
  belongs_to :project
  has_one_attached :photo
  validates :ordinal, presence: true
  validates :description, presence: true
end
