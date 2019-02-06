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
                   }
    follow = Following.new(attributes)

    expect(follow.login).to eq("bradpsheehan")
    expect(follow.html_url).to eq("https://github.com/bradpsheehan")
  end
end
