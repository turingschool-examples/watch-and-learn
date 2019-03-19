require 'rails_helper'

RSpec.describe UserGithubReposFacade do
  before :each do
    @user = create(:user)
    create(:github_token, user: @user, token: ENV['USER_2_GITHUB_TOKEN'])
  end
  it 'exists' do
    facade = UserGithubReposFacade.new(@user)
    expect(facade).to be_a(UserGithubReposFacade)
  end

  context 'instance methods' do
    it 'returns an array of repositories' do
      filename = 'user_1_github_repos.json'
      url = "https://api.github.com/user/repos"

      stub_get_json(url,filename)

      facade = UserGithubReposFacade.new(@user)
      expect(facade.user_repos.class).to eq(Array)

      facade.user_repos.each do |repo|
        expect(repo.class).to eq(Repository)
      end
    end

    it 'gets top repositories' do
      filename = 'user_1_github_repos.json'
      url = "https://api.github.com/user/repos"

      stub_get_json(url,filename)

      facade = UserGithubReposFacade.new(@user)

      expect(facade.top_user_repos(5).count).to eq(5)
    end

  end
end
