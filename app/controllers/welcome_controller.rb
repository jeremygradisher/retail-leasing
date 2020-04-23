class WelcomeController < ApplicationController
  def index
    if current_user
      if current_user.is_admin?
        @projects = Project.all
      else
        @projects = current_user.projects
      end
    end
  end
end
