namespace :permit_received_daily do
  desc "Alert SuperAdmins 5 days before permit received date"
  task send_permit_received_alert: :environment do
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)
    
    @schedules = Schedule.where(permit_received_date: (Date.today + 5.days).strftime("%m/%d/%Y")).ids
    
    if @schedules.count > 0
      @users.each do |user|
       PermitReceivedDateMailer.permit_received_date_email(user, @schedules).deliver_later
      end
    end
  end
#$ rake permit_received_daily:send_permit_received_alert
end
