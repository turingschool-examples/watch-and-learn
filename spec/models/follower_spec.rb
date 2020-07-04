require 'rails_helper'

describe Follower do
  it "exists" do
    attrs = {
      id: 1,
      login: "Jane",
      html_url: "http://www.jane.com",
    }
    follower = Follower.new(attrs)

    expect(follower).to be_a Follower
    expect(follower.id).to eq(1)
    expect(follower.login).to eq("Jane")
    expect(follower.html_url).to eq("http://www.jane.com")
  end
end
