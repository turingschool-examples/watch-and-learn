require 'rails_helper'

RSpec.describe UserGithubReposFacade do
  it 'exists' do
    facade = UserGithubReposFacade.new
    expect(facade).to be_a(UserGithubReposFacade)
  end

  context 'instance methods' do
    it 'returns an array of repositories' do
      filename = 'teresa_github_repos.json'
      url = "https://api.github.com/user/repos"

      stub_get_json(url,filename)

      facade = UserGithubReposFacade.new
      expect(facade.user_repos.class).to eq(Array)

      facade.user_repos.each do |repo|
        expect(repo.class).to eq(Repository)
      end
    end

    it 'gets top repositories' do
      filename = 'teresa_github_repos.json'
      url = "https://api.github.com/user/repos"

      stub_get_json(url,filename)

      facade = UserGithubReposFacade.new

      expect(facade.top_user_repos(5).count).to eq(5)
    end

  end
end
