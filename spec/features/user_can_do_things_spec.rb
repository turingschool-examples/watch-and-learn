require 'rails_helper'

describe 'as a user' do
  describe 'when logged in' do
    it 'shows things on dashboard' do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      token_1 = user_1.github_token

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/dashboard'
      expect(page).to have_content('Github')

      within('.github-list') do
        expect(page).to have_css('.repository', count: 5)
      end

      within('.following-list') do
        expect(page).to have_css('.following', count: 5)
      end

      within('.followers-list') do
        expect(page).to have_css('.follower', count: 5)
      end
    end

    it 'can log in with github' do
      stub_omniauth
      user_1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/dashboard'
      expect(page).to_not have_content('Followers')
      expect(page).to_not have_content('Github')

      click_button 'Connect to Github'

      expect(page.status_code).to eq(200)
      expect(page).to have_content('Github')
      expect(page).to have_content('Followers')
    end

    it 'can make friends' do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      user = create(:user, github_name: "mgoodhart")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit '/dashboard'

      within '.following-list' do
        within ".follow-0" do
          expect(page).to have_link("Add as Friend")
          click_link "Add as Friend"
        end
      end
      expect(page).to have_content("Added your new Friend!")
      expect(current_path).to eq(dashboard_path)

    end

  end
end
