class AddDealIdToSchedules < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :deal_id, :integer
  end
end
