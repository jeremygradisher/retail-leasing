class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.string :name
      t.integer :user_id
      t.string :key
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
