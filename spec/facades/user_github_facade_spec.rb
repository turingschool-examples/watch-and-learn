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
        mock_user_dashboard_github

        user = create(:user, github_token: ENV['github_key'])

        facade = UserGithubFacade.new(user)

        expect(facade.user_repos).to be_a(Array)
      end
    end

    context '#user_followers' do
      it 'returns a list of the user\'s followers' do
        mock_user_dashboard_github

        user = create(:user, github_token: ENV['github_key'])

        facade = UserGithubFacade.new(user)

        expect(facade.user_followers).to be_a(Array)
      end
    end

    context '#user_following' do
      it 'returns a list of the people a user is following' do
        mock_user_dashboard_github

        user = create(:user, github_token: ENV['github_key'])

        facade = UserGithubFacade.new(user)

        expect(facade.user_following).to be_a(Array)
      end
    end
  end
end
