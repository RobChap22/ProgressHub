class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :project_steps, through: :project
end
