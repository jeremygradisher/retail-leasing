class AddIndexToAreasDeals < ActiveRecord::Migration[5.0]
  def change
    add_index :areas_deals, [ :area_id, :deal_id ], :unique => true, :name => 'by_area_and_deal'
  end
end
