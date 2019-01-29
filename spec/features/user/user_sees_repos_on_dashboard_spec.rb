require 'rails_helper'

describe ' as a user' do
  context 'when I visit dashboard' do
    it 'should see github', :vcr do
      user = create(:user, github_token: ENV["GITHUB_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_css(".github")
      expect(page).to have_content("Github")
    end
    it 'should see repos', :vcr do
      user = create(:user, github_token: ENV["GITHUB_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      within ".github" do
        expect(page).to have_css(".repository", count: 5)
      end
    end
    it 'should have links', :vcr do
      user = create(:user, github_token: ENV["GITHUB_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
save_and_open_page
      within ".github" do
        expect(page).to have_css(".name-link")
      end
    end
  end
end
# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
