class CreateIcons < ActiveRecord::Migration[5.0]
  def change
    create_table :icons do |t|
      t.integer :project_id
      t.string :icon

      t.timestamps
    end
  end
end
