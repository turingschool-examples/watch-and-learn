require 'rails_helper'

RSpec.describe 'As a user when I am on my dashboard' do
  it 'I can authorize my account with github', :vcr do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :credentials => {:token => ENV['MY_TOKEN']}
      })

    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    click_link 'Connect to Github'

    expect(@user.connected?).to eq(true)
    expect(@user.token).to eq(ENV['MY_TOKEN'])
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('.user-repos')
    expect(page).to have_css('.user-followers')
    expect(page).to have_css('.user-followings')
  end
end
