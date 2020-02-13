require "rails_helper"

RSpec.describe EmailNotifierMailer, type: :mailer do
  it 'renders the subject' do
    current_user = create(:user)
    data = {email: 'nobody@example.com', name: "Harry"}
    mail = EmailNotifierMailer.inform(current_user, data).deliver_now

    expect(mail.to).to eq(['nobody@example.com'])
    expect(mail.from).to eq(['no-reply@turingturtorial.io'])
    expect(mail.body.encoded).to match(current_user.first_name)
    expect(mail.body.encoded).to match("Harry")
    expect(mail.body.encoded).to match("https://safe-brushlands-66817.herokuapp.com/register")
    expect(mail.subject).to eq('GitHub invitation.')
  end

  it 'cofirms a registered account' do
    user = create(:user)
    email = 'nobody@example.com'
    mail = VerificationEmailNotifierMailer.inform(user, email).deliver_now

    expect(mail.to).to eq(['nobody@example.com'])
    expect(mail.from).to eq(['no-reply@turingturtorial.io'])
    expect(mail.body.encoded).to match(user.first_name)
    expect(mail.body.encoded).to match("Confirm Your Account")
    expect(mail.subject).to eq("#{user.first_name} Account Created!")
  end
end
