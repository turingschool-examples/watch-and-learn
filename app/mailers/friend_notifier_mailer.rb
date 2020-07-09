class FriendNotifierMailer < ApplicationMailer

  def inform(user)
  @user = user
  #mail(to: friend_email, subject: "#{@user.first_name} is sending you an email")
  mail(to: @user.email, subject: "#{@user.first_name} is sending you an email")
  end
end
