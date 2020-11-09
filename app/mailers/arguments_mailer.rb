class ArgumentsMailer < ApplicationMailer
  default from: "no-reply@statusplanapp.com"

  def multiple_args_email(user)
    #Tenant.set_current_tenant(1)
    @user = user
    @member = user.member
    @projectscount = Project.where.not(status: 'Archived').count
    @areascount = Area.count
    @dealscount = Deal.count
    @userscount = User.all.count
    #@memberscount = Member.all.count
    @superadmincount = User.where(is_admin: true).count
    @admincount = User.where(role: 'Admin').count
    @editorcount = User.where(role: 'Editor').count
    @ucount = User.where(role: 'User').count
    
    @now = Time.now.in_time_zone('Eastern Time (US & Canada)').strftime("%A %B %d, %Y")
    mail(to: @user.email, subject: 'Multiple Arguments Test ' + @now)
  end
end
#$ rails runner "ArgumentsMailer.multiple_args_email(User.first).deliver_later"