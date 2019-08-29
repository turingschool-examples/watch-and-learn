require 'rails_helper'

feature 'as a user when i visit my dashboard' do
  scenario 'user can see a section for Github with a list of 5 repos linking to the repo on Github' do
    stub_dashboard_api_calls

    user = create(:user)
    user.token = ENV['GITHUB_API_KEY']
    user_2 = create(:user)
    user_2.token = ENV['GITHUB_API_KEY_2']
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Github")
    expect(page).to have_css(".repo", count: 5)

    within(first(".repo")) do
      expect(page).to have_css(".repo_name")
    end
  end
end
