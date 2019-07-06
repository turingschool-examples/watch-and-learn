# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'user goes to dashboard and sees 5 most recently updated repos' do
    VCR.use_cassette("features/user/user_sees_repos") do
      user = create(:user, github_token: ENV["GITHUB_TOKEN"])

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      visit '/dashboard'

      within '.github' do
        within '.repos' do
          expect(page).to have_css("#repo-1")
          expect(page).to have_css("#repo-2")
          expect(page).to have_css("#repo-3")
          expect(page).to have_css("#repo-4")
          expect(page).to have_css("#repo-5")
          expect(page).to_not have_css("#repo-6")
        end
      end

      within '#repo-1' do
        expect(page).to have_link("brownfield-of-dreams")
      end
    end
  end

  it 'authenticated user with no repos goes to dashboard and sees no repos' do
      OmniAuth.config.test_mode = true
      stub_omniauth

      user = create(:user)

      visit '/'

      click_on 'Sign In'

      expect(page).to_not have_css(".github")
      expect(page).to_not have_css(".repos")
      expect(page).to_not have_css(".followers")
      expect(page).to_not have_css(".following")

      expect(current_path).to eq(login_path)
      VCR.use_cassette("features/user/user_sees_followers") do
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password

        click_on 'Log In'

        visit '/dashboard'
      end

      click_button "Connect to Github"
      user.reload
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".github")
      expect(page).to have_css(".repos")
      expect(page).to have_content("No repos found")

    OmniAuth.config.mock_auth[:github] = nil
  end

  it 'unauthenticated user with no repos goes to dashboard and sees no repos' do
    VCR.use_cassette("features/user/user_sees_no_repos") do
      user = create(:user, github_token: nil)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      expect(page).to_not have_css(".github")
    end
  end
end
