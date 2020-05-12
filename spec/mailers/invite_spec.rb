require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  it "invite mailer" do 
    user = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        token: ENV['GH_TEST_KEY_1']})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    email_info = {inviter: 'Jordan Sewell', invitee: 'David Tran'}
    invitee = { email: 'fake@example.com' }
    email = described_class.inform(email_info, invitee).deliver_now 
    
    expect(email.subject).to eq("Jordan Sewell is inviting you to join their app!")
    expect(email.to).to have_content("fake@example.com")
    expect(email.from).to have_content("no-reply@turingtutorials.com")
    expect(email.body.encoded).to have_content("Hello David Tran,")
    expect(email.body.encoded).to have_link('here', href: "/register")
  end
end
