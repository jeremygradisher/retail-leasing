class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  
  validates_each :user_id, :on => [:create, :update] do |record, attr, value|
    c = value; p = record.project_id
    if c && p && # If no values, then that problem 
                 # will be caught by another validator
      UserProject.find_by_user_id_and_project_id(c, p)
      record.errors.add :base, 'This combination already exists'
    end
  end
end
