class WelcomeController < ApplicationController
  def index
    if current_user
      if current_user.is_admin?
        @projects = Project.all
        @projects = Project.where.not(status: ['Complete', 'Archived']).all
      else
        @projects = current_user.projects.where.not(status: ['Complete', 'Archived'])
      end
      
      #this needs to play into the search
      #@q = Project.by_user_plan_and_tenant(@tenant.id, current_user).where.not(status: ['Complete', 'Archived']).search(params[:q])
      #@projects = @q.result(distinct: true)
      
    end
  end
end
