require 'rails_helper'

RSpec.describe GithubService do
  it "exists" do
    service = GithubService.new
    expect(service).to be_a(GithubService)
  end

  context "instance methods" do
    it "gets user repositories" do
      VCR.use_cassette("services/find_user_repos") do
        service = GithubService.new
        results = service.get_repos
        repository = results.first
        expect(repository[:name]).to eq("battleship")
        expect(repository[:html_url]).to eq("https://github.com/m-mrcr/battleship")
      end


    end
  end
end
