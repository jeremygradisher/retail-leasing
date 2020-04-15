class CreateAreasDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :areas_deals do |t|
      t.references :area, index: true, foreign_key: true
      t.references :deal, index: true, foreign_key: true

      t.timestamps
    end
  end
end
