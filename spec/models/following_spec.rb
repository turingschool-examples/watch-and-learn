require 'rails_helper'

describe Following do
  it "exists" do
    following_data = {
      login: "following name",
      html_url: "www.following_name.com"
    }

    following = Following.new(following_data)

    expect(following).to be_a Following
    expect(following.handle).to eq("following name")
    expect(following.url).to eq("www.following_name.com")
  end
end
