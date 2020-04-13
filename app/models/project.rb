class Project < ApplicationRecord
  belongs_to :user
  
  has_many :maps, dependent: :destroy
  has_many :areas, dependent: :destroy
  
  has_many :icons, dependent: :destroy
  accepts_nested_attributes_for :icons
end
