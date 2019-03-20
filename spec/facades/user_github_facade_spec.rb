require 'rails_helper'

describe UserGithubFacade do
  it 'exists' do
    attributes = {}
    facade = UserGithubFacade.new(attributes)

    expect(facade).to be_a(UserGithubFacade)
  end

  context 'instance methods' do
    context '#user_repos' do
      it 'returns a list of the user\'s first 5 repos' do
        filename = 'user_repos.json'
        url = "https://api.github.com/user/repos"
        stub_get_json(url, filename)
        user = create(:user, github_token: ENV['github_key'])

        facade = UserGithubFacade.new(user)

        expect(facade.user_repos).to be_a(Array)
      end
    end

    context '#user_followers' do
      it 'returns a list of the user\'s followers' do
        filename = 'user_followers.json'
        url = "https://api.github.com/user/followers"
        stub_get_json(url, filename)

        user = create(:user, github_token: ENV['github_key'])

        facade = UserGithubFacade.new(user)

        expect(facade.user_followers).to be_a(Array)
      end
    end

    context '#user_following' do
      it 'returns a list of the people a user is following' do
        WebMock.disable!
        # filename = 'user_following.json'
        # url = "https://api.github.com/user/following"
        # stub_get_json(url, filename)

        user = create(:user, github_token: ENV['github_key'])

        facade = UserGithubFacade.new(user)

        expect(facade.user_following).to be_a(Array)
      end
    end
  end
end
