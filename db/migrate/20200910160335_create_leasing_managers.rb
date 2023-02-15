class CreateLeasingManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :leasing_managers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
