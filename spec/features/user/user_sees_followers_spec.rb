require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with a token' do
    it 'shows a list of all followers with their handles linking to their Github profile', :vcr do
      user = create(:user, token: "cheezytoken")
      token_1 = user.token

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      user_1_followers = Follower.find_all_followers(token_1)

      expect(page).to have_content("Followers")
      within('.followers') do
        expect(page).to have_link("#{user_1_followers.first.login}")
        expect(page).to have_link("#{user_1_followers.last.login}")
        expect(page).to have_css(".follower")
      end
    end

  end
end
