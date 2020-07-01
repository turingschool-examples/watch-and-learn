require 'rails_helper'

describe 'A registered user' do
  it "can see a github section with 5 repos" do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    expect(page).to have_css('.github')
  end

  it "can't see a github section if user has no token" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    expect(page).to_not have_css('.github')
  end

  it "can see a github section with only thier repos" do
    user_1 = create(:user, token: ENV["GITHUB_TOKEN"])
    user_2 = create(:user, token: ENV["GITHUB_TOKEN_2"])
    user_1_repos = GithubResults.new.repos(user_1.token)
    user_2_repos = GithubResults.new.repos(user_2.token)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit(dashboard_path)

    within(first('.repo-link')) do
      expect(page).to have_content(user_1_repos.first.name)
      expect(page).to_not have_content(user_2_repos.first.name)
    end

  end

end
