require 'rails_helper'

describe GithubService do
  context "instance methods" do
    it "gets repository information" do
      VCR.use_cassette("services/find_repositories") do
        token = ENV["GITHUB_API_KEY"]
        service = GithubService.new(token)

        result = service.repository_info
        repository = result.first

        expect(repository).to be_a(Hash)
        expect(repository[:name]).to eq("Bookclub")
      end
    end

    it "gets follower information" do
      VCR.use_cassette("services/find_followers") do
        token = ENV["GITHUB_API_KEY"]
        service = GithubService.new(token)

        result = service.follower_info
        follower = result.first

        expect(follower).to be_a(Hash)
        expect(follower[:login]).to eq("chitasan")
      end
    end


  end
end
