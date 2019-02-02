describe AccountActivationMailer, type: :mailer do

  let(:user) { create(:user) }
  let(:mail) { AccountActivationMailer.send_activation_request(user) }
  it "sends the user an email with a link to activate their account" do
    expect(mail.to).to eq(user.email)
    expect(mail.subject).to eq("Account Activation")
    expect(mail.from).to eq("no-reply@turing-tutorials.io")

    expect(mail.body).to match("Visit here to activate your account.")
    click_link("here")
    expect(current_path).to eq(account_activation_path(user))
  end

end
