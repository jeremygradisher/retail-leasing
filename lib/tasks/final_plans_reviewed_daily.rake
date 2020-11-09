namespace :final_plans_reviewed_daily do
  desc "Alert SuperAdmins 5 days before final plans reviewed date"
  task send_final_plans_reviewed_alert: :environment do
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)
    
    @schedules = Schedule.where(final_plans_reviewed_date: (Date.today + 5.days).strftime("%m/%d/%Y")).ids
    
    if @schedules.count > 0
      @users.each do |user|
       FinalPlansReviewedDateMailer.final_plans_reviewed_date_email(user, @schedules).deliver_later
      end
    end
  end
#$ rake final_plans_reviewed_daily:send_final_plans_reviewed_alert
end
