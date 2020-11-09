namespace :test_email_project do
  desc "Test Send to Project ID 1"
  task send_to_project_users: :environment do
    @project = Project.find(1)
    @project_users = @project.users

    @project_users.each do |u|
     MultipleMailer.multiple_email(u).deliver_later
    end
  end
end
#$ rake test_email_project:send_to_project_users