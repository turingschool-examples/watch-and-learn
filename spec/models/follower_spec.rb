require 'rails_helper'

describe Follower do
  it "exists" do
    attributes = {}
    repository = Follower.new(attributes)

    expect(repository).to be_a(Follower)
  end
  it "has attributes" do
    attributes = { login: "bradpsheehan",
                  html_url: "https://github.com/bradpsheehan"
                  }
    follower = Follower.new(attributes)
    
    expect(follower.login).to eq("bradpsheehan")
    expect(follower.html_url).to eq("https://github.com/bradpsheehan")
  end

  describe 'class methods', :vcr do
    it ".find_all_followers" do
      user = create(:user, token: "tokentoken")
      token = user.token
      followers = Follower.find_all_followers(token)

      expect(followers.first).to be_an_instance_of(Follower)
    end
  end
end
