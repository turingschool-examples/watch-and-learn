# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it "user goes to dashboard and sees links to the accounts they're following" do
    VCR.use_cassette("features/user/user_sees_following") do
      user = create(:user, github_token: ENV["GITHUB_TOKEN"])

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      within '.github' do
        within '.following' do
          expect(page).to have_css("#following-1")
        end
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
      VCR.use_cassette("features/user/user_sees_following") do
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password

        click_on 'Log In'

        visit '/dashboard'
      end

      click_button "Connect to Github"
      user.reload
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css(".github")
      expect(page).to have_css(".following")
      expect(page).to have_content("No followings found")

      OmniAuth.config.mock_auth[:github] = nil
  end

  it 'unauthenticated user with no repos goes to dashboard and sees no repos' do
    VCR.use_cassette("features/user/user_sees_following") do
      user = create(:user, github_token: nil)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      expect(page).to_not have_css(".github")
      expect(page).to_not have_css(".following")

    end
  end

end
