class EmailNotifierMailer < ApplicationMailer
  def inform(user, git_user)
    @user = user
    mail(to: git_user, subject: "GitHub invitation.")
  end
end
