class ProjectStep < ApplicationRecord
  belongs_to :project
  validates :ordinal, presence: true
  validates :description, presence: true
end
