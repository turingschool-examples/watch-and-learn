require 'rails_helper'

describe GithubService do
  it 'exists' do
    service = GithubService.new

    expect(service).to be_a(GithubService)
  end

  describe "instance methods" do
    it "get repositories" do
      VCR.use_cassette("github service repos") do
        service = GithubService.new

        result = service.get_repos
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:name)
      end
    end

    it "get followers" do
      VCR.use_cassette("github service followers") do
        service = GithubService.new

        result = service.get_followers
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:login)
      end
    end

    it "get following" do
      VCR.use_cassette("github service following") do
        service = GithubService.new

        result = service.get_following
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:login)
      end
    end
  end
end
