require 'rails_helper'

describe Following do
  it "exists" do
    attributes = {}
    follow = Following.new(attributes)

    expect(follow).to be_a(Following)
  end
  it "has attributes" do
    attributes = { login: "bradpsheehan",
                  html_url: "https://github.com/bradpsheehan",
                  uid: nil }
    follow = Following.new(attributes)

    expect(follow.login).to eq("bradpsheehan")
    expect(follow.html_url).to eq("https://github.com/bradpsheehan")
    expect(follow.uid).to eq(nil)
  end

  describe 'class methods', :vcr do
    it ".find_all_following" do
      user = create(:user, oauth_token: ENV["GITHUB_TOKEN"])
      token = user.oauth_token
      following = Following.find_all_following(token)

      expect(following.first).to be_an_instance_of(Following)
    end
  end
  describe 'instance methods', :vcr do
    it "#has_account?" do
      user = create(:user, oauth_token: ENV["GITHUB_TOKEN"])
      token = user.oauth_token
      following = Following.find_all_following(token)
      following_1 = following.first

      following_2 = Following.new(login: "wandadog", html_url: "https://github.com/wandadog", uid: 12345)
      expect(following_1.uid).to eq(nil)
      expect(following_1.has_account?).to eq(false)
      expect(following_2.has_account?).to eq(true)
    end
  end
end
