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
                  }
    follower = Follower.new(attributes)
    expect(follower.login).to eq("bradpsheehan")
    expect(follower.html_url).to eq("https://github.com/bradpsheehan")
  end

end
