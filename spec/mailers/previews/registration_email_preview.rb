# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class UserMailerPreview < ActionMailer::Preview
  def registration_email_preview
    user = User.find_by(email: "adagonese@gmail.com")
    UserMailer.registration_email(user)
  end
end
