class CreateAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :areas do |t|
      t.string :suite_number
      t.integer :map_id
      t.string :status
      t.string :coords
      t.belongs_to :map, index: true, foreign_key: true

      t.timestamps
    end
  end
end
