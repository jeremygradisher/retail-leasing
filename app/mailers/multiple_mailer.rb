class MultipleMailer < ApplicationMailer
  default from: "no-reply@statusplanapp.com"

  def multiple_email(user)
    @user = user
    mail(to: @user.email, subject: 'Multiple Emailer')
  end
end

#taken from here https://launchschool.com/blog/handling-emails-in-rails
#need to make it multiple. Here maybe: https://gist.github.com/maxivak/8460f022f5b369626069

#$ rails runner "MultipleMailer.multiple_email(User.first).deliver_later"

