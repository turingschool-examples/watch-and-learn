require 'rails_helper'

RSpec.describe 'As a user connected to GitHub', :vcr, type: :feature do
  before(:each) do
    @user = create(:user, github_token: ENV['GITHUB_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I visit /dashboard' do
    before(:each) do
      visit '/dashboard'
    end

    it 'Then I should see a button that says "Disconnect Github Account"' do
      expect(page).to have_button('Disconnect GitHub Account')
    end

    it 'I should see sections for Follower, Following, and Repos' do
      expect(page).to have_content('Your Followers')
      expect(page).to have_content('Following')
      expect(page).to have_content('Your GitHub Repos')
    end

    describe 'And when I click on "Disconnect"' do
      before(:each) do
        click_on 'Disconnect GitHub Account'
      end

      it 'Then I should be redirected to /dashboard' do
        expect(current_path).to eq('/dashboard')
      end

      it 'And I should not see Github repos, followers, and following' do
        expect(page).to_not have_content('Your Followers')
        expect(page).to_not have_content('Following')
        expect(page).to_not have_content('Your GitHub Repos')
      end

      it "and I should see link to 'Connect to GitHub'" do
        expect(page).to have_link('Connect to GitHub')
      end
    end
  end
end
