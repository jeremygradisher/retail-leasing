class Project < ApplicationRecord
  belongs_to :user
  
  has_many :maps, dependent: :destroy
  has_many :areas, dependent: :destroy
end
