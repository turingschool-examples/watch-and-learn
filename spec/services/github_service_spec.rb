require 'rails_helper'

describe GithubService do
  context 'instance methods' do
    context '#repos' do
      it "returns repo hashes" do
        service = GithubService.new
        repos = service.repos
        expect(repos).to be_a Array
        expect(repos.first).to be_a Hash

        expect(repos.first).to have_key :name
        expect(repos.first).to have_key :html_url
      end
    end
  end
end
