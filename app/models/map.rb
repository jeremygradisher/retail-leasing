class Map < ApplicationRecord
  belongs_to :user
  
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  
  has_many :areas, dependent: :destroy
end
