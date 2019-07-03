require "rails_helper"

describe GithubService do
  it "finds all repositories" do
    VCR.use_cassette("github/github_repositories") do
      service = GithubService.new(ENV["GITHUB_API_KEY"])
      #TODO update to Oauth
      repositories = service.find_repositories
      repo = repositories.first

      expect(repositories.count).to eq(30)
      expect(repo[:name]).to eq("book_club")
      expect(repo[:html_url]).to eq("https://github.com/chakeresa/book_club")
    end
  end
end
