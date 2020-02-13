class UserNotifierMailer < ApplicationMailer
  def inform(user, friend_contact)
    @user = user
    @friend_contact = friend_contact
    mail(to: friend_contact, subject: "#{@user.first_name} invites you to TuringTutorials")
  end

  def activate(user, user_email)
    @user = user
    @user_email = user_email
    mail(to: user_email, subject: "Activate your Turing Tutorials account")
  end 
end
