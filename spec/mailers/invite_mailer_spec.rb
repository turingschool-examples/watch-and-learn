require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  describe '#invite' do
    let(:user) { create(:user, activated?: true) }
    let(:invitee_login) { 'octocat' }
    let(:invitee_email) { 'octo@cat.com' }
    let(:mail) { described_class.invite(user, invitee_login, invitee_email).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Join Turing Video Tutorials')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([invitee_email])
    end

    it 'assigns a registration link' do
      expect(mail.body.encoded)
        .to match('http://localhost:3000/users/new')
    end
  end
end
