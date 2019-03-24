require 'rails_helper'

context 'As a registered user' do
  context 'without a github_token' do
    it 'can connect to GitHub and see', :vcr do
      user = create(:user, email: "test@email.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      set_omniauth

      visit dashboard_path

      expect(page).to_not have_css("#user_github")
      expect(page).to_not have_css(".user_github_followers")
      expect(page).to_not have_content("Following")
      expect(page).to_not have_content("Repositories")
      expect(page).to_not have_content("Followers")
      expect(page).to_not have_css(".following")

      click_button "Connect to GitHub"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css("#user_github")
      expect(page).to have_content("Repositories")
      expect(page).to have_content("Followers")
      expect(page).to have_content("Following")
      expect(page).to have_css(".follower", count: 5)
      expect(page).to have_css(".follower_handle", count: 5)
      expect(page).to have_css(".user_github_followers")
      expect(page).to have_css(".follower")
      expect(page).to have_css(".follower_handle")
      expect(page).to have_css(".following", count: 5)
      expect(page).to have_css(".following_handle", count: 5)
    end
  end
end
