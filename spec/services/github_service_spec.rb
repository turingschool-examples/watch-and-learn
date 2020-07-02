require 'rails_helper'

describe GithubService do
  context "instance methods" do
    it "returns all repos" do
      service = GithubService.new
      repos = service.repos
      expect(repos).to be_an Array
      expect(repos.first).to be_a Hash
      repo_1 = repos.first

      expect(repo_1).to have_key :name
      expect(repo_1).to have_key :html_url
    end

    it "returns all followers" do
      service = GithubService.new
      followers = service.followers
      expect(followers).to be_an Array
      expect(followers.first).to be_a Hash
      follower_1 = followers.first

      expect(follower_1).to have_key :login
      expect(follower_1).to have_key :html_url
    end

    it "returns all following" do
      service = GithubService.new
      followings = service.followings
      expect(followings).to be_an Array
      expect(followings.first).to be_a Hash
      following_1 = followings.first

      expect(following_1).to have_key :login
      expect(following_1).to have_key :html_url
    end
  end
end
