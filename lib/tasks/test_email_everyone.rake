namespace :test_email_everyone do
  desc "Test to email all users"
  task send_to_everyone: :environment do
    @users = User.all
    
    @users.each do |u|
     MultipleMailer.multiple_email(u).deliver_later
    end
  end
end
#$ rake test_email_everyone:send_to_everyone