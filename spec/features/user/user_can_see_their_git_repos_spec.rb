require 'rails_helper'

describe 'as a logged in user on my dashboard' do
  it 'sees a section for github and their collection of repos' do
    json_response = File.open("./fixtures/user_repos.json")
    stub_request(:get, "https://api.github.com/user/repos").
      to_return(status: 200, body: json_response)

    user = create(:user, git_key: ENV["GITHUB_API_KEY"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # When I visit /dashboard
    visit dashboard_path

    # Then I should see a section for "Github"
    expect(page).to have_content("Github")

    # And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
    expect(page).to have_css('.repository', count: 5)
  end
end
