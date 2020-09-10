class AddMoreFieldsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :address, :string
    add_column :projects, :city, :string
    add_column :projects, :state, :string
    add_column :projects, :zip, :string
    add_column :projects, :project_type, :string
    add_column :projects, :description, :text
    add_column :projects, :owner, :string
    add_column :projects, :owner_address, :string
    add_column :projects, :owner_city, :string
    add_column :projects, :owner_state, :string
    add_column :projects, :owner_zip, :string
    add_column :projects, :owner_contact, :string
    add_column :projects, :owner_email, :string
    add_column :projects, :owner_phone, :string
    add_column :projects, :project_square_feet, :integer
    add_column :projects, :status, :string
  end
end
