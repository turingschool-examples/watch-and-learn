require "rails_helper"

RSpec.describe ActivationMailer, type: :mailer do
  describe 'activation' do
    before(:each) do
      @user = create(:user)
      @mail = described_class.activation(@user).deliver_now
    end
    it 'renders the subject' do
      expect(@mail.subject).to eq('BROWNFIELD OF DREAMS Account Activation')
    end
    it 'renders the receiver email' do
      expect(@mail.to.first).to eq(@user.email)
    end
    it 'renders the email content' do
      expect(@mail.body.encoded).to have_content('to activate your account.')
    end
  end
end
