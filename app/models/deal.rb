class Deal < ApplicationRecord
  belongs_to :project
  belongs_to :map
  
  has_many :areas_deals, :dependent => :destroy
  has_many :areas, through: :areas_deals
end
