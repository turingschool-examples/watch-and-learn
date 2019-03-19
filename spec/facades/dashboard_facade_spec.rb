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

    describe '.followers' do
      it 'returns all followers for the user' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])
        VCR.use_cassette("/facades/dashboard_follower_request") do
          facade = DashboardFacade.new(user)

          expect(facade.followers).to be_a(Array)
          expect(facade.followers.first).to be_a(GithubUser)
        end
      end
    end

    describe '.following' do
      it 'returns all followed users on github' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])
        VCR.use_cassette("/facades/dashboard_following_request") do
          facade = DashboardFacade.new(user)

          expect(facade.following).to be_a(Array)
          expect(facade.following.first).to be_a(GithubUser)
        end
      end
    end
  end
end
