require 'rails_helper'

RSpec.describe 'github api service' do
  it 'returns repos', :vcr do
    service = GithubSearchResults.new(create(:user, github_token: ENV['github_api_key']))
    array_of_hashes_data = service.repos

    expect(service).to be_an_instance_of(GithubSearchResults)

    expect(array_of_hashes_data).to be_a(Array)
    expect(array_of_hashes_data.first).to have_key(:name)
    expect(array_of_hashes_data.first).to have_key(:url)
    expect(array_of_hashes_data.count).to eq(30)
  end
end
