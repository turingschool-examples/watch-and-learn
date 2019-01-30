require 'rails_helper'

describe GithubService do
  it 'exists' do
    user = create(:user)

    service = GithubService.new(user)

    expect(service).to be_a(GithubService)
  end
  it 'returns repositories', :vcr do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])
    service = GithubService.new(user)

    repos = service.repos_by_user

    expect(repos.count).to eq(30)
    expect(repos.first).to have_key(:name)
    expect(repos.first).to have_key(:html_url)
  end
  it 'returns followers', :vcr do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])
    service = GithubService.new(user)

    followers = service.followers_by_user

    expect(followers.count).to eq(30)
    expect(followers.first).to have_key(:login)
    expect(followers.first).to have_key(:html_url)
  end
end
