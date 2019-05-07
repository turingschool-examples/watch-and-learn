require "rails_helper"

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list
# of 5 repositories with the name of each Repo
# linking to the repo on Github

describe 'when logged in user visits root path' do
  it 'he can see github repos' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within "#github-section" do
      expect(page).to have_content('github.com')
    end
  end
end
