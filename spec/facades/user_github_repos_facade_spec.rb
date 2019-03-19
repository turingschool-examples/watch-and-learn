require 'rails_helper'

RSpec.describe UserGithubReposFacade do
  it 'exists' do
    facade = UserGithubReposFacade.new
    expect(facade).to be_a(UserGithubReposFacade)
  end

  context 'instance methods' do
    it 'returns an array of repositories' do
      json_response = File.open('./fixtures/github_repos.json')

      stub_request(:get, "https://api.github.com/user/repos").
        to_return(status: 200, body: json_response)

      facade = UserGithubReposFacade.new
      expect(facade.repos.class).to eq(Array)
      
      facade.repos.each do |repo|
        expect(repo.class).to eq(Repository)
      end
    end

  end
end
