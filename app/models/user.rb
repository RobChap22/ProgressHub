class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_projects
  has_many :projects
  has_many :projects_as_learner, through: :user_projects, source: :projects
  validates :username, presence: true, uniqueness: true
end
