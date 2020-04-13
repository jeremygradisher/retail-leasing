class AddProjectIndexToAreas < ActiveRecord::Migration[5.0]
  def change
    add_index :areas, :project_id
  end
end
