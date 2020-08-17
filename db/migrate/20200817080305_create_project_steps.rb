class CreateProjectSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :project_steps do |t|
      t.integer :ordinal
      t.text :description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
