class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :project_steps, through: :project

  def percent_completed
    (last_completed.to_f / project_steps.count) * 100
  end
end
