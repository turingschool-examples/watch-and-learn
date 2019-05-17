# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def invite(friend, user)
    @friend = friend[:login]
    @user = user
    mail(to: friend[:email], subject: "Hey #{friend[:login]}, join our site!")
  end
end
