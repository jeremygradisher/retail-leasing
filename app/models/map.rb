class Map < ApplicationRecord
  belongs_to :project
  
  has_many :areas, dependent: :destroy
  #accepts_nested_attributes_for :areas
  has_many :deals, dependent: :destroy
  
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
end
