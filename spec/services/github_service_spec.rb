require 'rails_helper'


RSpec.describe GithubService do

  before :each do
    user = create(:user, github_token: ENV['GITHUB_PAT'])
    @service = GithubService.new(user)
  end

  it "gets repos of user", :vcr do
    repos = @service.repos

    expect(repos.count).to eq(5)
  end

  it "gets followers of user", :vcr do
    followers = @service.followers
    follower = followers.first[:login]

    expect(follower).to eq('331smblk')
  end

  it "gets followees of user", :vcr do
    followees = @service.following
    following = followees.first[:login]

    expect(following).to eq('iandouglas')
  end

  it "gets email by github handle", :vcr do
    email = @service.email_search('milevy1')

    expect(email[:email]).to eq('milevy1@gmail.com')
  end
end
