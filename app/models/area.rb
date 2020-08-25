class Area < ApplicationRecord
  belongs_to :project
  belongs_to :map
  
  has_one :schedule, dependent: :destroy
  
  has_many :areas_deals, :dependent => :destroy
  has_many :deals, through: :areas_deals
end
