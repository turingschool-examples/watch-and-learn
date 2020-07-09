require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#repo_resp" do
      it "returns repo data", :vcr do
        user = create(:user)
        user.update(github_token: ENV["GITHUB_TOKEN_A"])
        service = GithubService.new(user)
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
      it "returns follower data", :vcr do
        user = create(:user)
        user.update(github_token: ENV["GITHUB_TOKEN_A"])
        service = GithubService.new(user)
        search = service.follower_resp
        expect(search).to be_an Array

        follower = search.first
        expect(follower).to be_a Hash

        expect(follower).to have_key :id
        expect(follower).to have_key :login
        expect(follower).to have_key :html_url
      end
    end

    context '#following_resp' do
      it "returns following data", :vcr do
        user = create(:user)
        user.update(github_token: ENV["GITHUB_TOKEN_B"])
        service = GithubService.new(user)
        search = service.following_resp
        expect(search).to be_an Array

        following = search.first
        expect(following).to be_a Hash

        expect(following).to have_key :id
        expect(following).to have_key :login
        expect(following).to have_key :html_url
      end
    end

    context '#user_resp' do
      it "returns user email", :vcr do
        user = create(:user)
        user.update(github_token: ENV["GITHUB_TOKEN_A"])
        service = GithubService.new(user)
        search = service.user_resp(ENV["GITHUB_USERNAME_B"])
        expect(search).to be_a Hash
        expect(search).to have_key :email

        bad_search = service.user_resp("Imprettysurethisisntavalidgithubname")
        expect(bad_search).to be_a Hash
        expect(bad_search).to have_key :message
      end
    end
  end
end
