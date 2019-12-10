require "rails_helper"

RSpec.describe InviteMailer, :vcr, type: :mailer do
  it 'sends invite email to newly registered user' do
    user = create(:user, first_name: 'Bob', last_name: 'G', email: 'bob@gmail.com', token: ENV['MY_TOKEN'])
    facade = InviteFacade.new(user, 'not-zorro')
    mail = InviteMailer.invite(facade)

    mail.subject.should eq("#{facade.current_user.github_name} has invited you to Brownfield.")
    mail.to.should eq([facade.invitee_email])
    mail.from.should eq(['no-reply@david-laura.com'])
  end
end
