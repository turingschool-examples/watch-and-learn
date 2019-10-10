require 'rails_helper'

describe UserFacade do
  it 'initializes GithubApiService' do
    user = create(:user, github_token: ENV["GITHUB_API_KEY"])
    facade = UserFacade.new(user)

    expect(facade.service).to be_a(GithubApiService)
  end

  it 'can return github repo data' do
    user = create(:user, github_token: ENV["GITHUB_API_KEY"])
    facade = UserFacade.new(user)

    json_response = File.open('./spec/fixtures/github_repo_data.json')

    stub_request(:get, "https://api.github.com/user/repos")
    .to_return(status: 200, body: json_response)

    data = facade.repo_data

    expect(data[0]).to be_a(Repo)
    expect(data.count).to eq(5)
    expect(data[0].name).to_not eq(nil)
    expect(data[0].html_url).to_not eq(nil)
  end

  it 'can return github follower data' do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])
    facade = UserFacade.new(user)

    json_response = File.open('./spec/fixtures/github_follower_data.json')

    stub_request(:get, "https://api.github.com/user/follower")
    .to_return(status: 200, body: json_response)

    data = facade.follower_data

    expect(data[0]).to be_a(GithubUser)
    expect(data.count).to eq(8)
    expect(data[0].login).to_not eq(nil)
    expect(data[0].html_url).to_not eq(nil)
  end
end
