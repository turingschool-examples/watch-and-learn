require 'rails_helper'

describe GithubService do
  it 'exists' do
    service = GithubService.new
    expect(service).to be_a(GithubService)
  end

  context 'instance methods' do
    context '#get_user_repos' do
      it 'returns repos', :vcr do
        filename = 'user_repos.json'
        url = "https://api.github.com/user/repos"
        stub_get_json(url, filename)
        user = create(:user, github_token: ENV["github_key"])

        service = GithubService.new

        result = service.get_user_repos(user)
        expect(result).to be_a(Array)
        expect(result[0]).to have_key(:html_url)
      end
    end
  end
end
