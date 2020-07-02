require 'rails_helper'

describe Follower do
  it "exists" do
    follower_data = {
      login: "follower name",
      html_url: "www.follower_name.com"
    }

    follower = Follower.new(follower_data)

    expect(follower).to be_a Follower
    expect(follower.handle).to eq("follower name")
    expect(follower.url).to eq("www.follower_name.com")
  end
end
