require 'rails_helper'

describe GithubService do
  context "instance methods" do
    it "returns all repos" do
      service = GithubService.new 
      repos = service.repos_body 
      expect(repos).to be_an Array
      expect(repos.first).to be_a Hash
      repo_1 = repos.first

      expect(repo_1).to have_key :name
      expect(repo_1).to have_key :html_url
    end
  end
end