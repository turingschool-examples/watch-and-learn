# frozen_string_literal: true

require 'rails_helper'

describe 'User logs in with Github' do
  it 'then user can see repo, followers, following info' do
    OmniAuth.config.test_mode = true
    stub_omniauth

    user = create(:user)

    visit '/'

    click_on 'Sign In'

    expect(page).to_not have_css('.github')

    expect(current_path).to eq(login_path)
    VCR.use_cassette('features/user/user_sees_followers') do
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'
    end

    click_button 'Connect to Github'
    user.reload
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('.github')
    expect(page).to have_css('.repos')
    expect(page).to have_css('.followers')
    expect(page).to have_css('.following')

    OmniAuth.config.mock_auth[:github] = nil
  end
end
