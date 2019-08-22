require "rails_helper"

describe Follower do
  it "exists" do
    attrs = {
      login: "user",
      url: "http://github.com/user",
    }

    follower = Follower.new(attrs)

    expect(follower).to be_a Follower
    expect(follower.login).to eq("user")
    expect(follower.url).to eq("http://github.com/user")
  end
end
