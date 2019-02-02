require 'rails_helper'

describe GithubFacade, type: :model do
  it 'exists' do
    github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"])
    expect(github_facade).to be_a(GithubFacade)
  end

  describe 'instance methods' do
    context '#owned_repos' do
      it 'returns num of repos for user given valid key' do
        json_response = File.open('./spec/fixtures/github_owner_repos.json')
        stub_request(:get, "https://api.github.com/user/repos?affiliation=owner").to_return(status: 200, body: json_response)
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"])

        repos = github_facade.owned_repos(5)
        expect(repos.count).to eq(5)
        expect(repos.first).to be_a(Repo)

        repos = github_facade.owned_repos(10)
        expect(repos.count).to eq(10)
        expect(repos.first).to be_a(Repo)
      end
    end
    context '#followers' do
      it 'returns followers for a user given valid key' do
        json_response = File.open('./spec/fixtures/github_user_followers.json')
        stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: json_response)
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"])

        followers = github_facade.followers
        expect(followers.count).to eq(9)
        expect(followers.first).to be_a(GithubUser)
      end
    end
    context '#following' do
      it 'returns following users for a user given valid key' do
        json_response = File.open('./spec/fixtures/github_user_following.json')
        stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: json_response)
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"])

        following = github_facade.following
        expect(following.count).to eq(3)
        expect(following.first).to be_a(GithubUser)
      end
    end
  end
end
