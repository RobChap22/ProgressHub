class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :user_projects
  has_many :messages, dependent: :destroy
  has_many :projects
  has_many :projects_as_learner, -> (user) { where.not(user: user) }, through: :user_projects, source: :project
  validates :username, presence: true, uniqueness: true

end
