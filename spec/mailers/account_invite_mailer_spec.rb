require "rails_helper"

describe AccountInviteMailer, type: :mailer do
  it "sends the user an email with a link to activate their account" do
    invite = double('invite')
    allow(invite).to receive(:invitee_email) {'abc@def.ghi'}
    allow(invite).to receive(:invitee_name) {'joe'}
    allow(invite).to receive(:inviter_name) {'Olive'}
    mail = AccountInviteMailer.invite(invite)

    expect(mail.to).to eq([invite.invitee_email])
    expect(mail.subject).to eq("Olive invites you to the Turing Tutorials App.")
    expect(mail.from).to eq(["no-reply@turing-tutorials.io"])

    expect(mail.body.encoded).to match("Olive has invited you to join Turing Tutorials.")
    expect(mail.body).to have_link("Click here to get started", href: get_started_url)
  end

end
