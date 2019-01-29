require 'rails_helper'

describe 'on the GithubService' do
  it "it exists" do
    token = 'adsfadsgkasl'
    ghs = GithubService.new(token)

    expect(ghs).to be_a(GithubService)
  end

  describe 'instance methods' do
    it '.repositories' do
      VCR.use_cassette("services/find_repositories") do
        token = ENV["GITHUB_API_KEY"]
        repositories = GithubService.new(token).repositories

        expect(repositories).to be_a(Array)
        expect(repositories.first).to have_key(:name)
        expect(repositories.first).to have_key(:html_url)
      end
    end
  end
end
