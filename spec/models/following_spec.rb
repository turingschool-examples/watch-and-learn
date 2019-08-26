require "rails_helper"

describe Following do
  it "exists" do
    attrs = {
      login: "user",
      html_url: "http://github.com/user"
    }

    following = Following.new(attrs)

    expect(following).to be_a Following
    expect(following.login).to eq("user")
    expect(following.url).to eq("http://github.com/user") 
  end
end
