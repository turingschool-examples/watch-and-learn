require 'rails_helper'

describe UserReposFacade do
  it 'exists' do
    WebMock.disable!
    attributes = {}
    facade = UserReposFacade.new(attributes)

    expect(facade).to be_a(UserReposFacade)
  end

  context 'instance methods' do
    context '#user_repos' do
      

      it 'returns a list of the user\'s first 5 repos' do
        WebMock.disable!
        user = create(:user, github_token: ENV['github_key'])

        facade = UserReposFacade.new(user)

        expect(facade.user_repos).to be_a(Array)
      end
    end
  end
end
