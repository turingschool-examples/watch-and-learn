require 'rails_helper'

describe GithubService do
	before :each do
		@github_service = GithubService.new(ENV['GITHUB_API_KEY'])
	end

  it "exists" do
		expect(@github_service).to be_a(GithubService)
  end

  describe "instance methods" do
    it "returns repositories", :vcr do
      search = @github_service.repository_data
      expect(search).to be_a Array
      expect(search.count).to eq 30
      expect(search[0]).to be_an Hash
      member_data = search[0]

      expect(member_data).to have_key :name
    end

    it "returns followers", :vcr do
      search = @github_service.follower_data
      expect(search).to be_a Array
      expect(search.count).to eq 4
      expect(search[0]).to be_an Hash
      follower_data = search[0]

      expect(follower_data).to have_key :login
    end

		it "returns following", :vcr do
			search = @github_service.following_data
			expect(search).to be_an Array
			expect(search.count).to eq 4
			expect(search[0]).to be_a Hash
			following_data = search[0]

			expect(following_data).to have_key :login
		end
  end
end
