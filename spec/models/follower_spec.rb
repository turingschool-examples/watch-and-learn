require 'rails_helper'

describe Follower, type: :model do

  it "exists" do
    attributes = {
      login: "My favorite Follower",
      html_url: "localhost:3000"
    }
    follower = Follower.new(attributes)
    expect(follower).to be_a(Follower)
  end

  it "has attributes" do
    attributes = {
      login: "My favorite Follower",
      html_url: "localhost:3000"
    }
    follower = Follower.new(attributes)
    expect(follower.login).to eq("My favorite Follower")
    expect(follower.html_url).to eq("localhost:3000")
  end
end
