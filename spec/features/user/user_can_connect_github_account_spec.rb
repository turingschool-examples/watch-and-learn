require 'rails_helper'

RSpec.describe 'As a user not yet connected to GitHub', :vcr, type: :feature do
  before :each do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I visit /dashboard' do
    before(:each) do
      visit '/dashboard'
    end

    it 'Then I should see a link that is styled like a button that says "Connect to Github"' do
      expect(page).to have_link('Connect to GitHub')
    end

    it 'I should not see a GitHub section or Follower, Following, and Repo sections' do
      expect(page).to_not have_content('Your Followers')
      expect(page).to_not have_content('Following')
      expect(page).to_not have_content('Your GitHub Repos')
    end

    describe 'And when I click on "Connect to Github"' do
      before(:each) do
        click_on 'Connect to GitHub'
      end

      it 'Then I should go through the OAuth process and be redirected to /dashboard' do
        expect(current_path).to eq('/dashboard')
      end

      it 'And I should see all of the content from the previous Github stories (repos, followers, and following)' do
        expect(page).to have_css('h2', text: "Your Followers")
        expect(page).to have_css('h2', text: "Following")
        expect(page).to have_css('h2', text: "Your GitHub Repos")
      end
    end
  end

  after do
    Rails.application.env_config["omniauth.auth"] = nil
  end
end
