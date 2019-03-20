require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    before :each do
      create(:user, github_token: 'abcd')
      @user_2 = create(:user, github_token: ENV['github_key'] )
      @user_3 = create(:user)
    end
    it 'can see a list of 5 of their GitHub repositories' do

      filename = 'user_repos.json'
      url = "https://api.github.com/user/repos"
      stub_get_json(url, filename)

      filename = 'user_followers.json'
      url = "https://api.github.com/user/followers"
      stub_get_json(url, filename)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)

      visit dashboard_path


      expect(page).to have_content("Github")
      expect(page).to have_css('.repos')
      within ".repos" do
        expect(page).to have_link('activerecord-obstacle-course')
        expect(page).to have_link(count: 5)
      end
    end

    it 'cannot see a GitHub section if they do not have a token' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_3)

      visit dashboard_path
      expect(page).to_not have_content("Github")
    end
  end
end
