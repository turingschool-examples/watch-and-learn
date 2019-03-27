class UserMailer < ActionMailer::Base
    default :from => "no-reply@brownfield.com"

 def registration_email(user)
    @user = user
    mail(:to => "#{@user.first_name} <#{@user.email}>", :subject => "Brownfield Confirmation")
 end

end
