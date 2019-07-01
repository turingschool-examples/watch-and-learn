require 'rails_helper'

describe "As a logged in user, on /dashboard" do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
  end
  context "There is a section for 'Github'" do
    it "Displays list of repository names each as links to their repo" do

      within(".github") do
        within(".github-repos") do
          expect(page).to have_css(".repo", count: 5)
          expect(page).to have_link("1901-mod2unes")
          expect(page).to have_link("2win_playlist")
          expect(page).to have_link("a-perilous-journey")
          expect(page).to have_link("activerecord-obstacle-course")
          expect(page).to have_link("activerecord-obstacle-course-1")
        end
      end
    end
  end
end

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
