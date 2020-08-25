class Project < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :project_steps, dependent: :destroy
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :messages, dependent: :destroy
  validates :title, presence: true
  acts_as_taggable_on :tags
end
