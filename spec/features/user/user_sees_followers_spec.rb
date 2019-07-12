# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'user dashboard shows followers with links to those followers githubs' do
    VCR.use_cassette('features/user/user_sees_followers') do
      user = create(:user, github_token: ENV['GITHUB_TOKEN_M'])

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      within '.github' do
        within '.followers' do
          expect(page).to have_css('#follower-1')
        end
      end
    end
  end
end
