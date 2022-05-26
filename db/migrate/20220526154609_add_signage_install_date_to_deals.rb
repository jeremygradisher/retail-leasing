class AddSignageInstallDateToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :signage_install_date, :string
  end
end
