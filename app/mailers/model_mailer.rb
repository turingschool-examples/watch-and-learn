class ModelMailer < ApplicationMailer
default from: "postman@example.com"

  def new_record_notification(user)
    @user = user
    mail to: @user.email, subject: "Welcome #{@user.first_name}"
  end
end
