require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context '#repo_json' do
      it "returns repo data" do
        user = create(:user, token: ENV["GITHUB_TOKEN"])
        service = GithubService.new
        search = service.repo_json(user)
        expect(search).to be_a Array
        expect(search[0]).to have_key "name"
        expect(search[0]).to have_key "url"
      end
    end
    context '#follower_json' do
      it "returns repo data" do
        user = create(:user, token: ENV["GITHUB_TOKEN"])
        service = GithubService.new
        search = service.follower_json(user)
        expect(search).to be_a Array
        expect(search[0]).to have_key "login"
        expect(search[0]).to have_key "url"
      end
    end
    context '#following_json' do
      it "returns repo data" do
        user = create(:user, token: ENV["GITHUB_TOKEN"])
        service = GithubService.new
        search = service.following_json(user)
        expect(search).to be_a Array
        expect(search[0]).to have_key "login"
        expect(search[0]).to have_key "url"
      end
    end
  end
end
