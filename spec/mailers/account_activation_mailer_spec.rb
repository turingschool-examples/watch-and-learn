require "rails_helper"

describe AccountActivatorMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:mail) { AccountActivatorMailer.activation_request(user) }
  it "sends the user an email with a link to activate their account" do
    expect(mail.to).to eq([user.email])
    expect(mail.subject).to eq("Activate")
    expect(mail.from).to eq(["no-reply@turing-tutorials.io"])

    expect(mail.body.encoded).to match("Visit here to activate your account")
    expect(mail.body).to have_link("Visit here to activate your account", href: account_activation_url(user))
  end

end
