class AddProjectIdToAreas < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :project_id, :integer
  end
end
