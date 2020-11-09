class ConstructionCompletionDateMailer < ApplicationMailer
    default from: "no-reply@statusplanapp.com"
    
    def construction_completion_date_email(user, schedules)
        #Tenant.set_current_tenant(1)
        @user = user
        #@member = @user.member
        @schedules = schedules
        @date = (Date.today + 5.days).strftime("%m/%d/%Y")
        @count = @schedules.count
        
        @now = Time.now.in_time_zone('Eastern Time (US & Canada)').strftime("%A %B %d, %Y")
        mail(to: @user.email, subject: 'Construction Completion Date (' + @date +') coming on ' + @count.to_s + ' Schedule(s)')
    end
end
