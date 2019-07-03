require "rails_helper"

describe GithubService  do
  it 'exists' do
    user = create(:user)
    github = GithubService.new(user)

    expect(github).to be_a GithubService
  end

  context '#get_repos' do
    it 'returns repo data' do
      VCR.use_cassette('grab_github_service_repo') do
        user = create(:user, username: 'CosmicSpagetti', github_token: ENV['BILLY_GITHUB_TOKEN'])
        github = GithubService.new(user)

        repos = github.repos

        expect(repos).to be_a Array
      end
    end
  end

  context '#get_followers' do
    it 'returns follower data' do
      VCR.use_cassette('grab_github_service_followers') do
        user = create(:user, username: 'CosmicSpagetti', github_token: ENV['BILLY_GITHUB_TOKEN'])
        github = GithubService.new(user)

        followers = github.followers

        expect(followers).to be_a Array
      end
    end
  end

  context '#get_following' do
    it 'returns following data' do
      VCR.use_cassette('grab_github_service_following') do
        user = create(:user, username: 'CosmicSpagetti', github_token: ENV['BILLY_GITHUB_TOKEN'])
        github = GithubService.new(user)

        following = github.following

        expect(following).to be_a Array
      end
    end
  end
end
