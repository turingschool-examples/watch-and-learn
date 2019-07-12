# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'user goes to dashboard and sees 5 most recently updated repos' do
    VCR.use_cassette('features/user/user_sees_repos') do
      user = create(:user, github_token: ENV['GITHUB_TOKEN_M'])
      create(:user, github_token: ENV['GITHUB_TOKEN_J'])

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      visit '/dashboard'

      within '.github' do
        within '.repos' do
          expect(page).to have_css('#repo-1')
          expect(page).to have_css('#repo-5')
          expect(page).to_not have_css('#repo-6')
        end
      end

      within '#repo-1' do
        expect(page).to have_link('brownfield-of-dreams')
      end
    end
  end
end
