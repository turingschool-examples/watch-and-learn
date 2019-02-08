class InviteNotifierMailer < ApplicationMailer
  def inform(current_user, friend_contact)
    @user = current_user
    @friend = friend_contact
    mail(to: @friend.email, subject: "#{@friend.name}, please join me in the Brownfield of Dreams. From: #{@user.first_name}")
  end
end
