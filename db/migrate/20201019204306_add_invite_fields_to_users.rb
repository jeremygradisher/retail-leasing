class AddInviteFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invited_by, :integer
    add_column :users, :project_id, :integer
  end
end
