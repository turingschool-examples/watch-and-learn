require 'rails_helper'

describe Follower do
  it "exists" do
    attrs = {
      login: "Jori P",
    }

    follower = Follower.new(attrs)

    expect(follower).to be_a Follower
    expect(follower.login).to eq("Jori P")
  end
end
