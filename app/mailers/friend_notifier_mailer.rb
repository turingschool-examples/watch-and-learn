class FriendNotifierMailer < ApplicationMailer

  def inform(info, recipient)
    @user = info[:user]
    @recipient = recipient

    mail(to: recipient)

  end
end
