class AddSquareFeetToAreas < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :area_sqft, :integer
  end
end
