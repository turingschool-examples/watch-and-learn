require 'rails_helper'


describe 'github api service' do
  it "github repo data", :vcr do

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    service = GithubApiService.new

    raw_data = service.get_repo_data(user)

    expect(service).to be_a(GithubApiService)
    expect(raw_data).to be_a(Array)

    expect(raw_data.first).to have_key(:name)
    expect(raw_data.first).to have_key(:html_url)
  end

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

  it "search user by login" do
    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    service = GithubApiService.new

    raw_data = service.search_user_login(user, "mackhalliday")

    expect(service).to be_a(GithubApiService)
    expect(raw_data).to be_a(Hash)

    expect(raw_data).to have_key(:login)
    expect(raw_data).to have_key(:email)
  end
end
