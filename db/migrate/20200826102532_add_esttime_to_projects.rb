class AddEsttimeToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :esttime, :string
  end
end
