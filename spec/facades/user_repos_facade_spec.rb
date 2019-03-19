require 'rails_helper'

describe UserReposFacade do
  it 'exists' do
    attributes = {}
    facade = UserReposFacade.new(attributes)

    expect(facade).to be_a(UserReposFacade)
  end

  context 'instance methods' do
    context '#user_repos' do
      it 'returns a list of the user\'s first 5 repos' do
        filename = 'user_repos.json'
        url = "https://api.github.com/user/repos"
        stub_get_json(url, filename)
        user = create(:user, github_token: ENV['github_key'])

        facade = UserReposFacade.new(user)

        expect(facade.user_repos).to be_a(Array)
      end
    end
  end
end
