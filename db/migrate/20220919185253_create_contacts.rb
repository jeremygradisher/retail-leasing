class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.integer :project_id
      t.text :notes
      t.text :additional

      t.timestamps
    end
    add_index :contacts, :project_id
  end
end
