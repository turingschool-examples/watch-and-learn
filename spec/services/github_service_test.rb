require 'rails_helper'

<<<<<<< HEAD
describe 'Github API service' do
  it "User Github Repo Data", :vcr do
=======
describe 'github api service' do
  it "github repo data", :vcr do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])
>>>>>>> 53b60ae17ce9c4f326c9af74bb352f65de63134d

    service = GithubApiService.new

    raw_data = service.get_repo_data(user)

    expect(service).to be_a(GithubApiService)
    expect(raw_data).to be_a(Array)

    expect(raw_data.first).to have_key(:name)
    expect(raw_data.first).to have_key(:html_url)
  end

<<<<<<< HEAD

=======
  it "github follower data", :vcr do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    service = GithubApiService.new

    raw_data = service.get_follower_data(user)

    expect(service).to be_a(GithubApiService)
    expect(raw_data).to be_a(Array)

    expect(raw_data.first).to have_key(:login)
    expect(raw_data.first).to have_key(:html_url)
  end

  it "github following data", :vcr do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    service = GithubApiService.new

    raw_data = service.get_following_data(user)

    expect(service).to be_a(GithubApiService)
    expect(raw_data).to be_a(Array)

    expect(raw_data.first).to have_key(:login)
    expect(raw_data.first).to have_key(:html_url)
  end
>>>>>>> 53b60ae17ce9c4f326c9af74bb352f65de63134d
end
