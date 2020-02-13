require 'rails_helper'
 
RSpec.describe 'Invite' do
    it "can send mail successfully" do
    user = create(:user)    
    user_2_email = "tyladevon@gmail.com"    
    email = UserNotifierMailer.inform(user, user_2_email)
    
    email.deliver_now
    
    mock_email = File.read('spec/fixtures/inform_email.html')
    
    expect(email.from.first).to eq("no-reply@turingtutorials.io")
    expect(email.to.first).to eq("tyladevon@gmail.com")
    expect(email.subject).to eq("#{user.first_name} invites you to TuringTutorials")
  end
end