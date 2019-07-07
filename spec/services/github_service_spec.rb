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

  it "finds all followers" do
    VCR.use_cassette("github/followers") do
      service = GithubService.new(ENV["GITHUB_API_KEY"])
      #TODO update to Oauth
      followers = service.find_followers
      follower = followers.first

      expect(followers.count).to eq(2)
      expect(follower[:login]).to eq("Loomus")
      expect(follower[:html_url]).to eq("https://github.com/Loomus")
    end
  end

  it "finds all following" do
    VCR.use_cassette("github/following") do
      service = GithubService.new(ENV["GITHUB_API_KEY"])
      #TODO update to Oauth
      following = service.find_following
      first_following = following.first

      expect(following.count).to eq(1)
      expect(first_following[:login]).to eq("DragonQuills")
      expect(first_following[:html_url]).to eq("https://github.com/DragonQuills")
    end
  end
end
