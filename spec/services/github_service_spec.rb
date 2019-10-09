require 'rails_helper'

describe "GithubService" do
  it "returns parsed repo data" do
    service = GithubService.new

    github_repos = service.get_repos

    expect(github_repos).to be_an Array

    expect(github_repos.first).to have_key(:name)
    expect(github_repos.first).to have_key(:html_url)
  end
end
