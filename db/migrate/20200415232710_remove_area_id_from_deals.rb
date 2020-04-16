class RemoveAreaIdFromDeals < ActiveRecord::Migration[5.0]
  def change
    remove_column :deals, :area_id, :integer
  end
end
