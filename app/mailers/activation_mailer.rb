require 'sendgrid-ruby'
require 'json'
class ActivationMailer
  include SendGrid

  def self.activate(user)
    from = Email.new(email: 'Admin@gmail.com')
    subject = "Activate Your Brownfield of Dreams Account"
    to = Email.new(email: user.email)
    content = Content.new(type: 'text/plain', value: "Visit here to activate your account")
    mail = SendGrid::Mail.new(from, subject, to, content)
    mail.to_json
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    response.status_code
    response.body
    response.headers
  end
end
