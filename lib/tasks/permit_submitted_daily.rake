namespace :permit_submitted_daily do
  desc "Alert SuperAdmins 5 days before permit submitted date"
  task send_permit_submitted_alert: :environment do
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)
    
    @schedules = Schedule.where(permit_submitted_date: (Date.today + 5.days).strftime("%m/%d/%Y")).ids
    
    if @schedules.count > 0
      @users.each do |user|
       PermitSubmittedDateMailer.permit_submitted_date_email(user, @schedules).deliver_later
      end
    end
  end
#$ rake permit_submitted_daily:send_permit_submitted_alert
end
