require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'registration_email' do
    let(:user) { mock_model User, first_name: "Lucas", email: "lucas@email.com", confirm_token: "12345678" }
    let(:mail) { UserMailer.registration_email(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Brownfield Confirmation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@brownfield.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to match("http://localhost:3000/users/#{user.confirm_token}/confirm_email")
    end
  end
end
