class AddProjectIdToMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :maps, :project_id, :integer
    remove_column :maps, :user_id
    add_index :maps, :project_id
  end
end
