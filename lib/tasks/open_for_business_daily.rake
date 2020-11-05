namespace :open_for_business_daily do
  desc "Alert SuperAdmins 5 days before open_for_business_date"
  task send_open_for_business_alert: :environment do
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)
    
    @schedules = Schedule.where(open_for_business_date: (Date.today + 5.days).strftime("%m/%d/%Y")).ids
    
    if @schedules.count > 0
      @users.each do |user|
       OpenForBusinessDateMailer.open_for_business_date_email(user, @schedules).deliver_later
      end
    end
  end
#$ rake open_for_business_daily:send_open_for_business_alert
end
