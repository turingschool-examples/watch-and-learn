require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with a token' do
    it "sees repos belonging to appropriate user", :vcr do
      user_1 = create(:user, oauth_token: ENV["GITHUB_TOKEN"])
      user_2 = create(:user, oauth_token: ENV["GITHUB_TOKEN_2"])
      token_1 = user_1.oauth_token
      token_2 = user_2.oauth_token

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit '/dashboard'
      user_1_repos = Repo.find_all_repos(token_1)
      user_2_repos = Repo.find_all_repos(token_2)

      within('.github-list') do
        expect(page).to have_link("#{user_1_repos.last.name}")
        expect(page).to_not have_link("#{user_2_repos.first.name}")
      end
    end
  end
end
