class Project < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :project_steps, dependent: :destroy
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :messages, dependent: :destroy
  validates :title, presence: true
  acts_as_taggable_on :tags

  after_create :create_user_project_for_creator

  private

  def create_user_project_for_creator
    UserProject.create(user: user, project: self)
  end
end
