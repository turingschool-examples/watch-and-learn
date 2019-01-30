require 'rails_helper'

describe Follower do
  it "exists" do
    attributes = {}
    follower = Follower.new(attributes)

    expect(follower).to be_a(Follower)
  end
  it "has attributes" do
    attributes = { login: "le3ah",
                   html_url: "https://github.com/le3ah"
                 }
    follower = Follower.new(attributes)
    expect(follower.login).to eq("le3ah")
    expect(follower.html_url).to eq("https://github.com/le3ah")
  end
end

describe 'class methods', :vcr do
  it ".find_all_followers" do
    user = create(:user, token: "tokentoken")
    token = user.token
    followers = Follower.find_all_followers(token)

    expect(followers.first).to be_an_instance_of(Follower)
  end
end
