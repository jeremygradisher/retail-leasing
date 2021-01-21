class AddDealIdToWorkletters < ActiveRecord::Migration[5.0]
  def change
    add_column :workletters, :deal_id, :integer
  end
end
