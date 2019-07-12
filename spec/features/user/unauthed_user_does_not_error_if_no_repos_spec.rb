# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'unauthenticated user with no repos goes to dashboard and sees no repos' do
    VCR.use_cassette('features/user/user_sees_following') do
      user = create(:user, github_token: nil)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      expect(page).to_not have_css('.github')
      expect(page).to_not have_css('.following')
    end
  end
end
