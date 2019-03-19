require 'rails_helper'

describe GithubService do
  it 'exists' do
    service = GithubService.new

    expect(service).to be_a(GithubService)
  end

  describe "instance methods" do
    it "get repositories" do
      VCR.use_cassette("github service") do
        service = GithubService.new

        result = service.get_repos
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:name)
      end
    end
  end

end
