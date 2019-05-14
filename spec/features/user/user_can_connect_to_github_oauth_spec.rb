require 'rails_helper'

describe 'As a registered User' do
  before :each do
    @user = create(:user)
  end
  context 'if I have not connected my github' do

    it "should have a button that says connect to github" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path

      expect(page).to have_button('Connect to Github')
    end

    it "should be able to make an omniauth connection" do
      VCR.use_cassette("services/view_gets_repositories") do

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit dashboard_path

        auth_hash = OmniAuth.config.mock_auth[:github]

        click_button "Connect to Github"

        expect(auth_hash[:credentials][:token]).to eq(@user.github_token)
      end
    end
  end
end
