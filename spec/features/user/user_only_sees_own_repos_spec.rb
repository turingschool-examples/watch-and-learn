require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with a token' do
    it "sees repos belonging to appropriate user", :vcr do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      user_2 = create(:user, github_token: ENV["GITHUB_TOKEN_2"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      facade_user_1 = UserDashboardFacade.new(user_1)
      repos_1 = facade_user_1.find_all_repos

      visit '/dashboard'
      expect(page).to_not have_content(user_2.first_name)
      within('.github-list') do
        expect(page).to have_link("#{repos_1.last.name}")
      end
    end
  end
end
