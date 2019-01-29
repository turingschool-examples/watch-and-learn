require 'rails_helper'

describe GithubFacade do
  it "it exists" do
    key = 'adsfadsgkasl'
    github_facade = GithubFacade.new(key)

    expect(github_facade).to be_a(GithubFacade)
  end

  describe 'instance methods' do
    it '.service' do
      key = 'adsfadsgkasl'
      github_facade = GithubFacade.new(key)

      expect(github_facade.service).to be_a(GithubService)
    end

    it '.repos' do
      VCR.use_cassette("services/find_repositories") do
        key = ENV["GITHUB_API_KEY"]
        github_facade = GithubFacade.new(key)
        repos = github_facade.repos

        expect(repos.count).to eq(5)
        expect(repos.first).to be_a(Repository)
      end
    end
  end
end
