require 'rails_helper'

describe GithubUser, type: :model do
  it "exists" do
    github_user = GithubUser.new({})
    expect(github_user).to be_a(GithubUser)
  end

  it "has attributes" do
    json = File.read('./spec/fixtures/github_user_followers.json')
    json_hash = JSON.parse(json, symbolize_names: true)
    follower = GithubUser.new(json_hash.first)

    expect(follower.login).to eq(json_hash.first[:login])
    expect(follower.html_url).to eq(json_hash.first[:html_url])
    expect(follower.email).to eq(json_hash.first[:email])
  end
end
