require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#repo_resp" do
      it "returns repo data" do
        user_2 = create(:user)
        user_2.update(github_token: ENV["GITHUB_TOKEN_A"])
        service = GithubService.new(user_2)
        search = service.repo_resp

        expect(search).to be_an Array

        repo_data = search.first
        expect(repo_data).to be_a Hash

        expect(repo_data).to have_key :id
        expect(repo_data).to have_key :name
        expect(repo_data).to have_key :html_url
      end
    end

    context "#follower_resp" do
      it "returns follower data" do
        user_2 = create(:user)
        user_2.update(github_token: ENV["GITHUB_TOKEN_A"])
        service = GithubService.new(user_2)
        search = service.follower_resp
        expect(search).to be_an Array

        follower = search.first
        expect(follower).to be_a Hash

        expect(follower).to have_key :id
        expect(follower).to have_key :login
        expect(follower).to have_key :html_url
      end
    end

    it "returns following data" do
      user_2 = create(:user)
      user_2.update(github_token: ENV["GITHUB_TOKEN_B"])
      service = GithubService.new(user_2)
      search = service.following_resp
      expect(search).to be_an Array

      following = search.first
      expect(following).to be_a Hash

      expect(following).to have_key :id
      expect(following).to have_key :login
      expect(following).to have_key :html_url
    end
  end
end
