# frozen_string_literal: true

require 'rails_helper'

describe GithubService do

  describe "users" do
    it "finds current user's five most recently updated repos" do
      VCR.use_cassette("repo_spec") do
        repos = GithubService.new.repo_info.take(5)
        repo = repos.first

        expect(repos.count).to eq(5)
        expect(repo[:name]).to eq("brownfield-of-dreams")
        expect(repo[:url]).to eq("https://api.github.com/repos/james-cape/brownfield-of-dreams")
      end
    end
  end
end
