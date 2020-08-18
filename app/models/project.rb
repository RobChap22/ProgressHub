class Project < ApplicationRecord
  belongs_to :user
  has_many :project_steps, dependent: :destroy
  has_many :user_projects
  has_many :users, through: :user_projects
  validates :title, presence: true
end
