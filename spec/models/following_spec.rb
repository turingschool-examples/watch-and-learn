require 'rails_helper'

describe Following do
  it "exists" do
    attrs = {
      id: 1,
      login: "Jane",
      html_url: "http://www.jane.com",
    }
    following = Following.new(attrs)

    expect(following).to be_a Following
    expect(following.id).to eq(1)
    expect(following.login).to eq("Jane")
    expect(following.html_url).to eq("http://www.jane.com")
  end
end
