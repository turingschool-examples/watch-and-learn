require 'rails_helper'

describe "As a logged in User" do
  it "I can connect to my Github account" do
    VCR.use_cassette('user_github_oauth') do
      OmniAuth.config.mock_auth[:github] = nil
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        :provider => 'github',
        :credentials => {
          :token => ENV["Github_access_token"]
        }
        })

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_on 'Connect to Github'

      expect(user.github_token).to eq(ENV["Github_access_token"])
    end
  end
end
