require 'rails_helper'

describe 'Github Service' do
  it 'exists' do
    user = create(:user)

    service = GithubService.new

    expect(service).to be_a(GithubService)
  end

  describe 'instance methods' do
    describe '.user_repositories' do
      it 'returns repository info for the current user' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])

        result = VCR.use_cassette("user_repositories") {
          GithubService.new.user_repositories(user)
        }

        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:name)
        expect(result[0]).to have_key(:html_url)
      end
    end
  end
end
