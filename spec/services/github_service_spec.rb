require 'rails_helper'

describe GithubService do
  it "exists" do
    service = GithubService.new

    expect(service).to be_a(GithubService)
  end

  describe "Instance Methods" do
    it "#get_repos" do
      VCR.use_cassette("services/get_repos") do
        repos = GithubService.new.get_repos

        expect(repos[0]).to be_a(Hash)
        expect(repos[0]).to have_key(:name)

        expect(repos[0][:name]).to eq("activerecord-obstacle-course")
        expect(repos[1][:name]).to eq("apollo_14")
        expect(repos[2][:name]).to eq("backend_prework")
        expect(repos[3][:name]).to eq("battleship")
        expect(repos[4][:name]).to eq("books")
      end
    end
  end
end
