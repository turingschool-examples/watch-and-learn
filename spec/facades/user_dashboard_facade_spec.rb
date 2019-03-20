require 'rails_helper'

RSpec.describe UserDashboardFacade do
  before :each do
    @user = create(:user)
    create(:github_token, user: @user, token: ENV['USER_2_GITHUB_TOKEN'])
  end
  it 'exists' do
    facade = UserDashboardFacade.new(@user)
    expect(facade).to be_a(UserDashboardFacade)
  end

  context 'instance methods' do
    it 'returns an array of repositories' do
      filename = 'user_1_github_repos.json'
      url = "https://api.github.com/user/repos"

      stub_get_json(url,filename)

      facade = UserDashboardFacade.new(@user)
      expect(facade.user_repos.class).to eq(Array)

      facade.user_repos.each do |repo|
        expect(repo.class).to eq(Repository)
      end
    end

    it 'gets top repositories' do
      filename = 'user_1_github_repos.json'
      url = "https://api.github.com/user/repos"

      stub_get_json(url,filename)

      facade = UserDashboardFacade.new(@user)

      expect(facade.top_user_repos(5).count).to eq(5)
    end

    it 'gets the github users the current user follows' do
      filename = 'users_that_user_1_follows.json'
      url = "https://api.github.com/user/following"

      stub_get_json(url,filename)

      facade = UserDashboardFacade.new(@user)

      expect(facade.users_followed.count).to eq(12)

    end

  end
end
