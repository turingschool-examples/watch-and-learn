require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#github_repos" do
      it "returns github data" do
        stub_dashboard_api_calls
        repos = subject.repos
        followers = subject.followers
        following = subject.following

        expect(repos).to be_a Array
        expect(repos[0]).to be_a Hash
        expect(repos.count).to eq(30)
        expect(repos[0]).to have_key :name

        expect(followers).to be_a Array
        expect(followers[0]).to be_a Hash
        expect(followers.count).to eq(4)
        expect(followers[0]).to have_key :login
        expect(followers[0]).to have_key :html_url

        expect(following).to be_a Array
        expect(following[0]).to be_a Hash
        expect(following.count).to eq(3)
        expect(following[0]).to have_key :login
        expect(following[0]).to have_key :html_url
      end
    end
  end
end
