class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :timeout_in => 4.hours
         
  has_many :user_avatars, dependent: :destroy
  accepts_nested_attributes_for :user_avatars
  
  has_many :user_projects, :dependent => :destroy
  has_many :projects, through: :user_projects
  
  after_create :create_user_project

  def create_user_project
    UserProject.create!(:user_id => id, :project_id => project_id)
  end
  
  def is_admin?
    is_admin
  end
end
