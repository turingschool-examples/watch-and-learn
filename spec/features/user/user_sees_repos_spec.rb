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
        expect(page).to_not have_css("#repo-6")
      end

      within '#repo-1' do
        expect(page).to have_link("brownfield-of-dreams", href: "https://github.com/james-cape/brownfield-of-dreams")
      end
    end
  end
end
