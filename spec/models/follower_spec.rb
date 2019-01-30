require "rails_helper"

RSpec.describe Follower, type: :model do
  it 'exists' do
    follower = Follower.new({})
    expect(follower).to be_a(Follower)
  end
  it 'has name and url attributes' do
    follower = Follower.new({login: "bla", html_url: "http://www.website.com"})
    expect(follower.name).to eq("bla")
    expect(follower.url).to eq("http://www.website.com")
  end
end
