# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Github Omniauth Authentication' do
  before :each do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      credentials: {
        token: ENV['GITHUB_PAT']
      }
    )

    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  it 'works with valid credentials' do
    user = create(:user)

    visit '/'

    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log In'
    click_link 'Connect To Github'

    within '#followers' do
      expect(page).to have_content('Followers')
      expect(page).to have_all_of_selectors('#follower-1', '#follower-2', '#follower-3', '#follower-4')
    end

    within '#following' do
      expect(page).to have_content('Following')
      expect(page).to have_all_of_selectors('#following-1', '#following-2', '#following-3', '#following-4')
    end
  end
end
