require 'rails_helper'

RSpec.feature "Omniauth login process"do
let(:user)  {create(:user)}

  it "omniauth asssigns github token to user" do
    
    stub_omniauth
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    # OmniAuth.config.add_mock(:github, {github_token: github_token})
    visit dashboard_path
    click_on "Connect to Github"

  end
  
end

def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      credentials: {token: ENV['GITHUB_ROSS_AUTH_TOKEN']}      
    })
end