namespace :lease_exec_daily do
  desc "Alert SuperAdmins 5 days before lease exec date"
  task send_lease_alert: :environment do
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)
    
    @schedules = Schedule.where(lease_execution_date: (Date.today + 5.days).strftime("%m/%d/%Y")).ids
    
    if @schedules.count > 0
      @users.each do |user|
       LeaseExecutionDateMailer.lease_execution_date_email(user, @schedules).deliver_later
      end
    end
  end
#$ rake lease_exec_daily:send_lease_alert
end

#This gets Schedules where lease_execution_date is equal to 5 days from now.
#$ schedules = Schedule.where(lease_execution_date: (Date.today + 5.days).strftime("%m/%d/%Y")).ids