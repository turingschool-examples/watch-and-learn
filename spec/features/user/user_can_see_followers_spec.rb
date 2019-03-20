require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can see a list of all of their github followers' do
      WebMock.disable!
      user = create(:user, github_token: ENV["github_key"])
      # filename = 'user_followers.json'
      # url = "https://api.github.com/user/followers"
      # stub_get_json(url, filename)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      save_and_open_page

      expect(page).to have_content("Github")
      expect(page).to have_content("Followers")

      expect(page).to have_css('.followers')
      within ".followers" do
        expect(page).to have_link('stiehlrod')
      end
    end
  end
end
