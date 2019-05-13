require 'rails_helper'

RSpec.describe 'as a user', type: :feature do
  describe 'when I visit my dashbaord' do
    before :each do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    end
    it 'Allows you to link your github account', :vcr do
      user = create(:user, token: nil)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to_not have_content("Your Repositories")
      expect(page).to_not have_content("People you Follow")
      click_link "Link your GitHub account"

      expect(page).to have_content("Your Repositories")
      expect(page).to have_content("People you Follow")
      expect(page).to_not have_link("Link your GitHub account")
    end
  end
end
