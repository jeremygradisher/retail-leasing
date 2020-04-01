class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :map_id
      t.string :image
      t.string :width
      t.string :height

      t.timestamps
    end
  end
end
