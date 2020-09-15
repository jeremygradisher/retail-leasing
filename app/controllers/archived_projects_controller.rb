class ArchivedProjectsController < ApplicationController
  def index
    if current_user
      @q = Project.where(status: ['Complete', 'Archived']).search(params[:q])
      @projects = @q.result(distinct: true)
    end
  end
end
