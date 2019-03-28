require 'rails_helper'

describe GithubService do
  it 'exists' do
    service = GithubService.new
    expect(service).to be_a(GithubService)
  end

  context 'instance methods' do
    context '#get_user_repos' do
      it 'returns repos', :vcr do
        user = create(:user, github_token: ENV["github_key"])

        service = GithubService.new

        result = service.get_user_repos(user)
        expect(result).to be_a(Array)
        expect(result[0]).to have_key(:html_url)
        expect(result[0]).to have_key(:full_name)
      end
    end
    context '#get_user_followers' do
    it 'returns followers', :vcr do
        user = create(:user, github_token: ENV["github_key"])

        service = GithubService.new

        result = service.get_user_followers(user)
        expect(result).to be_a(Array)

        expect(result[0]).to have_key(:login)
        expect(result[0]).to have_key(:html_url)
      end
    end

    context '#get_user_following' do
      it 'returns following', :vcr do
        user = create(:user, github_token: ENV["github_key"])

        service = GithubService.new

        result = service.get_user_following(user)
        expect(result).to be_a(Array)

        expect(result[0]).to have_key(:login)
        expect(result[0]).to have_key(:html_url)
      end
    end

    context '#get_user_email(username)' do
      it 'returns user\'s email', :vcr do
        user = create(:user, github_token: ENV["github_key"])
        service = GithubService.new

        result = service.get_user_email('manojpanta', user)
        expect(result).to be_a(String)
        expect(result).to eq('manojpanta95@gmail.com')
      end
    end
  end
end
