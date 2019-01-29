require 'rails_helper'

describe 'A registered user' do
  context 'when I visit /dashboard' do
    it 'sees a section for github' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content("GitHub Section")
      expect(page).to have_content("5 Repos")

      within "#repos" do

      #test for the attributes

      end
    end
  end
end


# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
