require 'rails_helper'

describe Follower, type: :model do
  it "exists" do
    follower = Follower.new({})
    expect(follower).to be_a(Follower)
  end

  it "has attributes" do
    json = File.read('./spec/fixtures/github_user_followers.json')
    json_hash = JSON.parse(json, symbolize_names: true)
    follower = Follower.new(json_hash.first)

    expect(follower.login).to eq(json_hash.first[:login])
    expect(follower.html_url).to eq(json_hash.first[:html_url])
  end
end
