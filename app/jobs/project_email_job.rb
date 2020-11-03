#this will email everyone from a project which is passed as the argument.
class ProjectEmailJob < ApplicationJob
  queue_as :default

  def perform(project)
    @project = Project.find(project)
    @project_users = @project.users
    @project_users.each do |u|
     MultipleMailer.multiple_email(u).deliver_later
    end
  end
end
#$ rails runner "ProjectEmailJob.perform_later(1)"