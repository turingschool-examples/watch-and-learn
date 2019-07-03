# frozen_string_literal: true

require 'rails_helper'

describe GithubService do

  describe "users" do
    it "finds current user's five most recently updated repos" do
      VCR.use_cassette("github_user_repo_search") do
        repos = GithubService.repo_info
        repo = repos.first

        expect(repos.count).to eq(5)
        expect(repo[:name]).to eq("brownfield-of-dreams")
        expect(repo[:url]).to eq("james-cape/brownfield-of-dreams")
      end
    end
  end
end
