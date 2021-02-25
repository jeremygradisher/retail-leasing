class CreatePrimaryDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :primary_deals do |t|
      t.references :area, index: true, foreign_key: true
      t.references :deal, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
