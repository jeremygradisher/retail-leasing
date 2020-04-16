class AddProjectIdToAreasDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :areas_deals, :project_id, :integer
    add_index :areas_deals, :project_id
  end
end
