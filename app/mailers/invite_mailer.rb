class InviteMailer < ApplicationMailer

  def invitation_email
    @user = params[:user]
    mail(to: @user.email, subject: 'You Have an Invitation!')
  end

end
