require 'rails_helper'

describe 'Github Service' do
  it 'exists' do
    user = create(:user)

    service = GithubService.new(nil)

    expect(service).to be_a(GithubService)
  end

  describe 'instance methods' do
    describe '.user_repositories' do
      it 'returns repository info for the current user' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])

        result = VCR.use_cassette("services/user_repositories") {
          GithubService.new(user).user_repositories
        }

        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:name)
        expect(result[0]).to have_key(:html_url)
      end
    end

    describe '.user_followers' do
      it 'returns follower info for the current user' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])

        result = VCR.use_cassette("services/user_followers") {
          GithubService.new(user).user_followers
        }

        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:login)
        expect(result[0]).to have_key(:html_url)
      end
    end

    describe '.user_following' do
      it 'returns users being followed by the current user' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])

        result = VCR.use_cassette("services/user_followers") {
          GithubService.new(user).user_following
        }

        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:login)
        expect(result[0]).to have_key(:html_url)
      end
    end
  end
end
