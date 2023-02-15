class CreateDealimages < ActiveRecord::Migration[5.0]
  def change
    create_table :dealimages do |t|
      t.string :dealimage
      t.belongs_to :deal, foreign_key: true

      t.timestamps
    end
  end
end
