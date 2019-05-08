require 'rails_helper'

describe Following, type: :model do

  it "exists" do
    attributes = {
      login: "My favorite Following",
      html_url: "localhost:3000"
    }
    following = Following.new(attributes)
    expect(following).to be_a(Following)
  end

  it "has attributes" do
    attributes = {
      login: "My favorite Following",
      html_url: "localhost:3000"
    }
    following = Following.new(attributes)
    expect(following.login).to eq("My favorite Following")
    expect(following.html_url).to eq("localhost:3000")
  end
end
