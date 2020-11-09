class SystemMailer < ApplicationMailer
  default from: "no-reply@statusplanapp.com"

  def super_admin_email(user)
    #Tenant.set_current_tenant(1)
    @user = user
    #@member = user.member
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
    mail(to: @user.email, subject: 'Super Admin Daily ' + @now)
  end
end

#taken from here https://launchschool.com/blog/handling-emails-in-rails

#we can run this through terminal if we pass the user instance
#$ rails runner "SystemMailer.super_admin_email(User.first).deliver_later"
#or in rails console
#$ SystemMailer.super_admin_email(User.first).deliver_later