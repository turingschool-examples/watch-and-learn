require 'rails_helper'

describe Follower do
  it "exists" do
    attributes = {}
    follower = Follower.new(attributes)

    expect(follower).to be_a(Follower)
  end
  it "has attributes" do
    attributes = { login: "bradpsheehan",
                  html_url: "https://github.com/bradpsheehan",
                  uid: nil }
    follower = Follower.new(attributes)
    expect(follower.login).to eq("bradpsheehan")
    expect(follower.html_url).to eq("https://github.com/bradpsheehan")
    expect(follower.uid).to eq(nil)
  end

  describe 'class methods', :vcr do
    it ".find_all_followers" do
      user = create(:user, oauth_token: ENV["GITHUB_TOKEN"])
      token = user.oauth_token
      followers = Follower.find_all_followers(token)

      expect(followers.first).to be_an_instance_of(Follower)
    end
  end
  describe 'instance methods', :vcr do
    it "#has_account?" do
      user = create(:user, oauth_token: ENV["GITHUB_TOKEN"])
      token = user.oauth_token
      followers = Follower.find_all_followers(token)
      follower_1 = followers.first

      follower_2 = Follower.new(login: "wandadog", html_url: "https://github.com/wandadog", uid: 12345)
      expect(follower_1.uid).to eq(nil)
      expect(follower_1.has_account?).to eq(false)
      expect(follower_2.has_account?).to eq(true)
    end
  end
end
