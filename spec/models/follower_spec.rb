require 'rails_helper'
describe Follower do
  it "creates correctly" do
    hash = {
      login: "mikedao",
      html_url: "google.com",
      id: 666
    }

    follower = Follower.new(hash)

    expect(follower.name).to eq(hash[:login])
    expect(follower.url).to eq(hash[:html_url])
    expect(follower.uid).to eq(hash[:id])
  end
end
