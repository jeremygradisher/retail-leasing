class Schedule < ApplicationRecord
  belongs_to :deal
  belongs_to :project
  
  #this was for notifications in StatusPlan
  #has_many :users, through: :user_projects
end
