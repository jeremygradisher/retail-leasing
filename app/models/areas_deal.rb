class AreasDeal < ApplicationRecord
  belongs_to :area
  belongs_to :deal
  
  validates_associated :area, :deal
end
