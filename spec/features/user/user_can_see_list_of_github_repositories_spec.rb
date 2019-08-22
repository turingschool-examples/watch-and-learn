require 'rails_helper'

feature 'as a user when i visit my dashboard' do
  scenario 'user can see a section for Github with a list of 5 repos linking to the repo on Github' do
    stub_dashboard_api_calls

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Github")
    expect(page).to have_css(".repo", count: 5)

    within(first(".repo")) do
      expect(page).to have_css(".repo_name")
      save_and_open_page
    end
  end
end
# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
