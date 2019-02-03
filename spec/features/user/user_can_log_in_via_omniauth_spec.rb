require 'rails_helper'

describe Github::SessionsController do

  before do
    @user = create(:user)
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "#create" do

    it "should redirect the user to the dashboard" do
      VCR.use_cassette("github-login") do
        visit "/auth/github"

        expect(current_path).to eq(dashboard_path)

        expect(@user.github_token).to be_truthy
        expect(@user.github_uid).to be_truthy
        expect(page).to have_css('section#github')
      end
    end
  end
end
