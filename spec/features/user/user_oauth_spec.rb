require 'rails_helper'

feature 'as a user when I visit my dashboard' do
  scenario 'I can connect to Github with a link styled like a button' do
    stub_dashboard_api_calls
    stub_github_oauth

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to_not have_css(".repo", count: 5)

    click_link "Connect to Github"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css(".repo", count: 5)

    within(first(".repo")) do
      expect(page).to have_css(".repo_name")
    end
  end
  OmniAuth.config.mock_auth[:github] = nil
end
