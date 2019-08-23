require 'rails_helper'

describe Following do
  it "exists" do
    attrs = {
      login: "Jori P",
    }

    following = Following.new(attrs)

    expect(following).to be_a Following
    expect(following.login).to eq("Jori P")
  end
end
