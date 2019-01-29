require 'rails_helper'

describe "Github Service Model" do
  it "exists" do
    github = GithubService.new("something")

    expect(github).to be_a(GithubService)
  end
  context "instance methods" do
    context "#all_repos" do
      it "returns a hash" do
        VCR.use_cassette("github_service") do
          github = GithubService.new(ENV["GITHUB_API_KEY"])

          expect(github.all_repos).to be_a(Array)
          expect(github.all_repos[0]).to be_a(Hash)
          expect(github.all_repos[0]).to have_key(:name)
          expect(github.all_repos[0]).to have_key(:html_url)
        end
      end
    end
  end
end
