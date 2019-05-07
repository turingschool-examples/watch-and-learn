require 'rails_helper'

describe 'as a logged in user on my dashboard' do
  it 'sees a section for github and their collection of repos' do
    # As a logged in user
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    # When I visit /dashboard
    # require 'pry'; bindin\g.pry
    visit dashboard_path
    # save_and_open_page
    # Then I should see a section for "Github"
    expect(page).to have_content("Github")

    # And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
    expect(page).to have_css('.repository', count: 5)
  end
end
