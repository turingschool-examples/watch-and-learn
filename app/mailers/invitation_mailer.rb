require 'sendgrid-ruby'
require 'json'
class InvitationMailer
  include SendGrid

  def self.invite(sender_username, sender_email, recipient_username, recipient_email)
      from = Email.new(email: sender_email)
      subject = "Invitation to join Brownfield of Dreams"
      to = Email.new(email: recipient_email)
      content = Content.new(type: 'text/plain', value: "Hello #{recipient_username}, #{sender_username} has invited you to join Brownfield of Dreams.You can create an account here: https://brownfield-of-dreams-1811.herokuapp.com/register")
      mail = SendGrid::Mail.new(from, subject, to, content)
      mail.to_json
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      response.status_code
      response.body
      response.headers
  end
end
