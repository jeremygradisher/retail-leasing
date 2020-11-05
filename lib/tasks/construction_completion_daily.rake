namespace :construction_completion_daily do
  desc "Alert SuperAdmins 5 days before construction_completion_date"
  task send_construction_completion_alert: :environment do
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)
    
    @schedules = Schedule.where(construction_completion_date: (Date.today + 5.days).strftime("%m/%d/%Y")).ids
    
    if @schedules.count > 0
      @users.each do |user|
       ConstructionCompletionDateMailer.construction_completion_date_email(user, @schedules).deliver_later
      end
    end
  end
#$ rake construction_completion_daily:send_construction_completion_alert
end
