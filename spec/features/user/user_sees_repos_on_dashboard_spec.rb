require 'rails_helper'

describe ' as a user' do
  context 'when I visit dashboard' do
    it 'should see github' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_css(".github")
      expect(page).to have_content("Github")
    end
    it 'should see repos' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_css(".repository", count: 5)

    end
    it 'should have links' do
    end
  end
end
# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
