class Project < ApplicationRecord
  belongs_to :user
  
  has_many :maps, dependent: :destroy
  has_many :areas, dependent: :destroy
  has_many :deals, dependent: :destroy
  has_many :areas_deals, dependent: :destroy
  has_many :workletter_templates, dependent: :destroy
  
  has_many :user_projects
  has_many :users, through: :user_projects, dependent: :destroy
  
  has_many :schedules, dependent: :destroy
  
  has_many :icons, dependent: :destroy
  accepts_nested_attributes_for :icons
  
  def self.by_user_plan(user)
      if user.is_admin?
      user.projects
      else
      user.projects
      end
  end
end
