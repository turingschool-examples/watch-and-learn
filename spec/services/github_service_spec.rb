require 'rails_helper'

describe GithubService do
  it 'exists' do
    user = create(:user)

    service = GithubService.new(user)

    expect(service).to be_a(GithubService)
  end
  it 'returns repositories', :vcr do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])
    service = GithubService.new(user)

    repos = service.repos_by_user

    expect(repos.count).to eq(30)
    expect(repos.first).to have_key(:name)
    expect(repos.first).to have_key(:html_url)
  end
  it 'returns followers', :vcr do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])
    service = GithubService.new(user)

    followers = service.followers_by_user

    expect(followers.first).to have_key(:login)
    expect(followers.first).to have_key(:html_url)
  end
  it 'returns following', :vcr do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])
    service = GithubService.new(user)
    
    following = service.following_by_user
    
    expect(following.first).to have_key(:login)
    expect(following.first).to have_key(:html_url)
  end
  it 'returns email from a username' do
    email_info = '{"email":"user@example.com"}'
    stub_request(:post, 'www.github.com').to_return(body: email_info, status: 200)
    
    response = GithubService.email_by_username(ENV['GITHUB_HANDLE'])
    expect(response[:email]).to eq('user@example.com')
  end
end
