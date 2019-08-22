require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#github_repos" do
      it "returns github data" do
        stub_dashboard_api_calls
        repos = subject.repos

        expect(repos).to be_a Array
        expect(repos[0]).to be_a Hash
        expect(repos.count).to eq(30)
        expect(repos[0]).to have_key :name
      end
    end
  end
end
