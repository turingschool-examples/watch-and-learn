require 'rails_helper'

describe GithubService do
  it 'exists', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(user)
    github_service = GithubService.new(user)

    expect(github_service).to be_a(GithubService)
  end

  it 'gets repos by user', :vcr do
    user = create(:user, name: "Wanda")
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(user)
    github_service = GithubService.new(user)
    repo = github_service.find_repos.first

    expect(github_service.find_repos.count).to eq(5)
    expect(repo).to have_key(:name)
    expect(repo).to have_key(:html_url)
  end

end
