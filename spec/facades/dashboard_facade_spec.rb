require 'rails_helper'

describe 'Dashboard facade' do
  it 'exists' do
    facade = DashboardFacade.new(nil)

    expect(facade).to be_a(DashboardFacade)
  end

  describe 'instance methods' do
    describe '.repositories' do
      it 'returns a collection of repositories for the user' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])
        VCR.use_cassette("/facades/dashboard_repositories_request") do
          facade = DashboardFacade.new(user)

          expect(facade.repositories).to be_a(Array)
          expect(facade.repositories.first).to be_a(Repository)
        end
      end
    end
  end
end
