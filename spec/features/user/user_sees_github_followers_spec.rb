require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with a token' do
    it "sees a Followers section within the Github section", :vcr do
      user = create(:user, github_token: ENV["GITHUB_TOKEN"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      facade_user = UserDashboardFacade.new(user)
      followers = facade_user.find_all_followers

      visit '/dashboard'

      expect(page).to have_content('Github')
      expect(page).to have_content('Followers')
      within('.followers-list') do
        expect(page).to have_link(followers.first.login)
        expect(page).to have_link(followers.last.login)
        expect(page).to have_css(".follower")
      end
    end
  end

  context 'as a logged in user without a token' do
    it "does not see links to followers' githubs", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_content("Followers")
      expect(page).to_not have_css(".followers-list")
    end
  end
end
