class Deal < ApplicationRecord
  belongs_to :project
  belongs_to :map
  
  has_many :areas_deals, :dependent => :destroy
  has_many :areas, through: :areas_deals
  
  has_many :dealimages, dependent: :destroy
  accepts_nested_attributes_for :dealimages
end
