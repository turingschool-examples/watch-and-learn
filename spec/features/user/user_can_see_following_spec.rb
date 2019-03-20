require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can see a list of everyone they are following on GitHub' do
      user = create(:user, github_token: ENV["github_key"])

      filename = 'user_following.json'
      url = "https://api.github.com/user/following"
      stub_get_json(url, filename)

      filename = 'user_followers.json'
      url = "https://api.github.com/user/followers"
      stub_get_json(url, filename)

      filename = 'user_repos.json'
      url = "https://api.github.com/user/repos"
      stub_get_json(url, filename)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content("Github")
      expect(page).to have_content("Following")

      expect(page).to have_css('.following')
      within ".following" do
        expect(page).to have_link('manojpanta')
      end
    end
  end
end
