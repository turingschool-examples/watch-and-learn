require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can see a list of all of their github followers' do
      user = create(:user, github_token: ENV["github_key"])

      mock_user_dashboard_github

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content("Github")
      expect(page).to have_content("Followers")

      expect(page).to have_css('.followers')
      within ".followers" do
        expect(page).to have_link('stiehlrod')
      end
    end
  end
end
