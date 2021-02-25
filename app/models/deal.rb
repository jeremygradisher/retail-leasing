class Deal < ApplicationRecord
  belongs_to :project
  belongs_to :map
  
  has_one :schedule, dependent: :destroy
  has_one :workletter, dependent: :destroy
  
  has_many :areas_deals, :dependent => :destroy
  has_many :areas, through: :areas_deals
  
  has_many :primary_deals, :dependent => :destroy
  
  has_many :dealimages, dependent: :destroy
  accepts_nested_attributes_for :dealimages
end
