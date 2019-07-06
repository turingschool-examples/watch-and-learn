# frozen_string_literal: true

require 'rails_helper'

describe GithubService do
  describe "users" do
    it "finds current user's five most recently updated repos" do
      VCR.use_cassette("repo_spec") do

        user = create(:user, github_token: ENV["GITHUB_TOKEN"])

        repos = GithubService.new(user).repo_info.take(5)
        repo = repos.first

        expect(repos.count).to eq(5)
        expect(repo[:name].class).to eq(String)
        expect(repo[:url]).to include("https://api.github.com/repos/")
      end
    end

    it "finds current user's followers" do
      VCR.use_cassette("follower_spec") do

        user = create(:user, github_token: ENV["GITHUB_TOKEN"])

        followers = GithubService.new(user).follower_info
        follower = followers.first

        expect(follower[:login].class).to eq(String)
        expect(follower[:url]).to include("https://api.github.com/users/")
      end
    end
  end
end
