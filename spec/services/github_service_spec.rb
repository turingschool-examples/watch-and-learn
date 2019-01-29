require 'rails_helper'

describe GithubService do
  it 'exists' do
    user = create(:user)

    service = GithubService.new(user)

    expect(service).to be_a(GithubService)
  end
  it 'returns repositories' do
    user = create(:user)

    service = GithubService.new(user)

    expect(service.repos_by_user.count).to eq(5)
    expect(service.repos_by_user.first).to have_key(:name)
    expect(service.repos_by_user.first).to have_key(:html_url)
  end
end
