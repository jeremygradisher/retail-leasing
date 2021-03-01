class PrimaryDeal < ApplicationRecord
  belongs_to :area
  belongs_to :deal
  belongs_to :project
  
  validates_each :area_id, :on => [:create, :update] do |record, attr, value|
    c = value; p = record.deal_id
    if c && p && # If no values, then that problem 
                 # will be caught by another validator
      PrimaryDeal.find_by_area_id_and_deal_id(c, p)
      record.errors.add :base, 'This combination already exists'
    end
  end
end
