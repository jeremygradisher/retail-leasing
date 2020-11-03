class PermitSubmittedDateMailer < ApplicationMailer
    default from: "no-reply@statusplanapp.com"
    
    def permit_submitted_date_email(user, schedules)
        #Tenant.set_current_tenant(1)
        @user = user
        #@member = @user.member
        @schedules = schedules
        @date = (Date.today + 5.days).strftime("%m/%d/%Y")
        @count = @schedules.count
        
        @now = Time.now.in_time_zone('Eastern Time (US & Canada)').strftime("%A %B %d, %Y")
        mail(to: @user.email, subject: 'Permit Submitted Date (' + @date +') coming on ' + @count.to_s + ' Schedule(s)')
    end
end
