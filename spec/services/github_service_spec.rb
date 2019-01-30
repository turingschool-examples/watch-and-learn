require 'rails_helper'

describe 'on the GithubService' do
  it "it exists" do
    token = 'adsfadsgkasl'
    ghs = GithubService.new(token)

    expect(ghs).to be_a(GithubService)
  end

  describe 'instance methods' do
    it '.repos' do
      VCR.use_cassette("services/find_repositories") do
        token = ENV["GITHUB_API_KEY"]
        repos = GithubService.new(token).repos

        expect(repos).to be_a(Array)
        expect(repos.first).to have_key(:name)
        expect(repos.first).to have_key(:html_url)
      end
    end
    it '.followers' do
      VCR.use_cassette("services/find_followers") do
        token = ENV["GITHUB_API_KEY"]
        followers = GithubService.new(token).followers

        expect(followers).to be_a(Array)
        expect(followers.first).to have_key(:login)
        expect(followers.first).to have_key(:html_url)
      end
    end
  end
end
