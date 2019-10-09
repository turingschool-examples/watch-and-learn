require 'rails_helper'

describe GithubRepoFacade do
  it 'initializes GithubApiService' do
    user = create(:user, github_token: ENV["GITHUB_API_KEY"])
    facade = GithubRepoFacade.new(user)

    expect(facade.service).to be_a(GithubApiService)
  end

  it 'can return github repo data' do
    user = create(:user, github_token: ENV["GITHUB_API_KEY"])
    facade = GithubRepoFacade.new(user)

    json_response = File.open('./spec/fixtures/github_data.json')

    stub_request(:get, "https://api.github.com/user/repos")
    .to_return(status: 200, body: json_response)

    data = facade.repo_data

    expect(data[0]).to be_a(Repo)
    expect(data.count).to eq(5)
    expect(data[0].name).to_not eq(nil)
    expect(data[0].html_url).to_not eq(nil)
  end
end
