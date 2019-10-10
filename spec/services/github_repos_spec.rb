require 'rails_helper'

RSpec.describe 'github api service' do
  it 'returns repos', :vcr do
    service = GithubSearchResults.new(create(:user, github_token: ENV['GITHUB_API_KEY']))
    array_of_hashes_data = service.repos

    expect(service).to be_an_instance_of(GithubSearchResults)

    expect(array_of_hashes_data).to be_a(Array)
    expect(array_of_hashes_data.first).to have_key(:name)
    expect(array_of_hashes_data.first).to have_key(:url)
    expect(array_of_hashes_data.count).to eq(30)
  end

  it 'returns followers', :vcr do
    service = GithubSearchResults.new(create(:user, github_token: ENV['GITHUB_API_KEY']))
    array_of_hashes_data = service.followers

    expect(service).to be_an_instance_of(GithubSearchResults)

    expect(array_of_hashes_data).to be_a(Array)
    expect(array_of_hashes_data.first).to have_key(:login)
    expect(array_of_hashes_data.first).to have_key(:html_url)
  end

  it 'returns followed accounts', :vcr do
    service = GithubSearchResults.new(create(:user, github_token: ENV['GITHUB_API_KEY']))
    array_of_hashes_data = service.followed_accounts

    expect(service).to be_an_instance_of(GithubSearchResults)

    expect(array_of_hashes_data).to be_a(Array)
    expect(array_of_hashes_data.first).to have_key(:login)
    expect(array_of_hashes_data.first).to have_key(:html_url)
  end
end
