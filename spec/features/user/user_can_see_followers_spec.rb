require 'rails_helper'

describe 'User Dashboard' do
  it 'displays users repos' do
    user = create(:user, github_token: ENV["GITHUB_ACCESS_TOKEN"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('.github') do
      # expect(page).to have_css(".follower", count: 4)
      expect(page).to have_content("melatran")
      expect(page).to have_content("stellakunzang")
      expect(page).to have_content("Rostammahabadi")
    end
  end
end




# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Followers"
# And I should see list of all followes with their handles linking to their Github profile
