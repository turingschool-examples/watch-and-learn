# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'user can sign in' do
    VCR.use_cassette("features/user/user_sees_repos") do

      user = create(:user)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      within '.github' do
        expect(page).to have_css("#repo-1")
        expect(page).to have_css("#repo-2")
        expect(page).to have_css("#repo-3")
        expect(page).to have_css("#repo-4")
        expect(page).to have_css("#repo-5")
      end

      within '#repo-1' do
        click_link
      end

      expect(current_path).to_not eq("/dashboard")
      expect(response).to be_successful
      expect(current_path[0,10]).to include("github.com")
    end
  end
end
