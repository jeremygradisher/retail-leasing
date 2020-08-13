class AddDealTermToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :deal_term, :integer
  end
end
