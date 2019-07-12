# frozen_string_literal: true

require 'rails_helper'

describe GithubService do
  describe 'users' do
    it "finds current user's five most recently updated repos" do
      VCR.use_cassette('repo_spec') do
        user = create(:user, github_token: ENV['GITHUB_TOKEN_M'])

        repos = GithubService.new(user).repo_info.take(5)
        repo = repos.first

        expect(repos.count).to eq(5)
        expect(repo[:name].class).to eq(String)
        expect(repo[:url]).to include('https://api.github.com/repos/')
      end
    end

    it "finds current user's followers" do
      VCR.use_cassette('follower_spec') do
        user = create(:user, github_token: ENV['GITHUB_TOKEN_M'])

        followers = GithubService.new(user).follower_info
        follower = followers.first

        expect(follower[:login].class).to eq(String)
        expect(follower[:url]).to include('https://api.github.com/users/')
      end
    end

    it "finds current user's followings" do
      VCR.use_cassette('following_spec') do
        user = create(:user, active: true, github_token: ENV['GITHUB_TOKEN_M'])

        followings = GithubService.new(user).following_info
        following = followings.first

        expect(following[:login].class).to eq(String)
        expect(following[:url]).to include('https://api.github.com/users/')
      end
    end

    it "finds current user" do
      VCR.use_cassette('user_spec') do
        user = create(:user, active: true, github_token: ENV['GITHUB_TOKEN_M'])

        user = GithubService.new(user).user("WHomer")

        expect(user[:login].class).to eq(String)
        expect(user[:email].class).to eq(String)
        expect(user[:url]).to include('https://api.github.com/users/')
      end
    end
  end
end
