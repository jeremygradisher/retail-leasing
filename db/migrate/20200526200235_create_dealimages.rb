class CreateDealimages < ActiveRecord::Migration[5.0]
  def change
    create_table :dealimages do |t|
      t.integer :deal_id
      t.string :dealimage
      t.belongs_to :deal, foreign_key: true

      t.timestamps
    end
  end
end
