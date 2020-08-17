class AddLastCompletedToUserProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :user_projects, :last_completed, :integer, default: 0
    add_column :user_projects, :completed, :boolean, default: false
    remove_column :user_projects, :status, :string
  end
end
