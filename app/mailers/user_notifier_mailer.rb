class UserNotifierMailer < ApplicationMailer
  def inform(user, friend_contact)
    @user = user
    @friend_contact = friend_contact
    mail(to: friend_contact, subject: "#{@user.first_name} invites you to TuringTutorials")
  end
end
