class AddDealIdToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :deal_id, :integer
    add_index :contacts, :deal_id
  end
end
