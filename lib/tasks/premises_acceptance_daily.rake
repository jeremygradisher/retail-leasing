namespace :premises_acceptance_daily do
  desc "Alert SuperAdmins 5 days before premises_acceptance_date"
  task send_premises_acceptance_alert: :environment do
    #Tenant.set_current_tenant(1)
    @users = User.where(is_admin: true)
    
    @schedules = Schedule.where(premises_acceptance_date: (Date.today + 5.days).strftime("%m/%d/%Y")).ids
    
    if @schedules.count > 0
      @users.each do |user|
       PremisesAcceptanceDateMailer.premises_acceptance_date_email(user, @schedules).deliver_later
      end
    end
  end
#$ rake premises_acceptance_daily:send_premises_acceptance_alert
end
