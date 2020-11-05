namespace :multi_args do
  desc "Testing sending multiple args to email"
  task send_multiarg_emails: :environment do
    #this is making sure Milia understands the tenant
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)

    @users.each do |user|
     ArgumentsMailer.multiple_args_email(user).deliver_later
    end
  end
#$ rake multi_args:send_multiarg_emails
end
