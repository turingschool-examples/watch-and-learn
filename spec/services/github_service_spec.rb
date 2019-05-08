require 'rails_helper'

describe GithubService do
  context "instance methods" do
    it "gets github information" do
      VCR.use_cassette("services/find_repositories") do
        user = create(:user, github_token: ENV["GITHUB_API_KEY"])
        service = GithubService.new(user)

        result = service.github_info
        repository = result.first

        expect(repository).to be_a(Hash)
        expect(repository[:name]).to eq("Bookclub")
      end
    end
  end
end
