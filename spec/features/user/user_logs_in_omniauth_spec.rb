require 'rails_helper'

RSpec.describe "as a user", :vcr do
  it "logs in to github" do
  OmniAuth.config.test_mode = true
  user = create(:user)
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    :provider => 'github',
    :credentials => {:token => ENV['GITHUB_TOKEN']}
  })

  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

  visit '/dashboard'
  expect(page).to have_content("Login Through Github")
  expect(page).not_to have_css(".repos")
  expect(page).not_to have_css(".followers")
  expect(page).not_to have_css(".following")

  click_link("Login Through Github")

  expect(page).not_to have_content("Login Through Github")
  expect(page).to have_css(".repos")
  expect(page).to have_css(".followers")
  expect(page).to have_css(".following")

  OmniAuth.config.mock_auth[:github] = nil
  end
end
