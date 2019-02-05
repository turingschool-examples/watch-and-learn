require "rails_helper"

RSpec.describe InviterMailer, type: :mailer do
  describe 'invitation' do
    before(:each) do
      @user = create(:user)
      @user_info = { name: 'Octocat', email: 'octocat@github.com'}
      @mail = described_class.invite(@user_info, @user).deliver_now
    end
    it 'renders the subject' do
      expect(@mail.subject).to eq('Join our Turing Tutorials app!')
    end
    it 'renders the receiver email' do
      expect(@mail.to.first).to eq(@user_info[:email])
    end
    it 'renders the email content' do
      expect(@mail.body.encoded).to have_content("#{@user.first_name + ' ' + @user.last_name} has invited you to join BROWNFIELD OF DREAMS Turing Tutorials. You can create an account")
    end
  end
end
