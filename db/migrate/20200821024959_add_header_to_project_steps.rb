class AddHeaderToProjectSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :project_steps, :header, :string
  end
end
