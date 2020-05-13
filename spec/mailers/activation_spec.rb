require "rails_helper"

RSpec.describe ActivationMailer, type: :mailer do
  it "activation email" do
    email_info = "David Tran"
    invitee = "fake@example.com"
    email = described_class.inform(email_info, invitee).deliver_now

    expect(email.subject).to eq("Please activate your account for Turing Tutorials.")
    expect(email.to).to have_content("fake@example.com")
    expect(email.from).to have_content("no-reply@turingtutorials.com")
    expect(email.body.encoded).to have_content("Hello David Tran,")
    expect(email.body.encoded).to have_link('here', href: "/activate")
  end
end
