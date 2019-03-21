require 'rails_helper'

describe 'A registered user without a github token' do
  context 'visiting /dashboard' do
    it 'can connect their account to github' do
      user = create(:user)
      login_as(user)

      visit dashboard_path
      expect(page).to_not have_content("Followers")
      expect(page).to_not have_content("Following")

      mock_user_dashboard_github

      click_on 'Connect To Github'

      expect(page).to_not have_link("Connect To Github'")
      expect(page).to have_content("Followers")
      expect(page).to have_content("Following")
    end
  end
end
