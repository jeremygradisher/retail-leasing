class Area < ApplicationRecord
  belongs_to :project
  belongs_to :map

  validates_presence_of :coords
  
  has_many :areas_deals, :dependent => :destroy
  has_many :deals, through: :areas_deals
  
  has_many :primary_deals, :dependent => :destroy

  

end
