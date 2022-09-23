class WelcomeController < ApplicationController
  def index
    if current_user
      if current_user.is_admin?
        #@projects = Project.all
        #@projects = Project.where.not(status: ['Complete', 'Archived']).all
        @q = Project.where.not(status: ['Complete', 'Archived']).ransack(params[:q])
        @projects = @q.result(distinct: true)
      else
        #@projects = current_user.projects.where.not(status: ['Complete', 'Archived'])
        @q = Project.by_user_plan(current_user).where.not(status: ['Complete', 'Archived']).ransack(params[:q])
        @projects = @q.result(distinct: true)
      end
    end
  end
end
