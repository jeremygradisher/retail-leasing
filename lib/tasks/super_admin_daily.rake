namespace :super_admin_daily do
  desc "Send Daily Super Admin Email"
  task send_daily_emails: :environment do
    #this is making sure Milia understands the tenant
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)
    
    @users.each do |u|
     SystemMailer.super_admin_email(u).deliver_later
    end
  end
end
#$ rake super_admin_daily:send_daily_emails