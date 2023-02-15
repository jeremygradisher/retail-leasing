class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.string :deal_name
      t.integer :gross_area
      t.integer :net_rentable_area
      t.string :lease_status
      t.integer :area_id
      t.belongs_to :map, index: true, foreign_key: true
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
