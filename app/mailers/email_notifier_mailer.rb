class EmailNotifierMailer < ApplicationMailer
  def inform(user, data)
    @user = user
    @sendee = data[:name]
    mail(to: data[:email], subject: "GitHub invitation.")
  end
end
