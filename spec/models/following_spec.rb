require "rails_helper"

RSpec.describe Following, type: :model do
  it 'exists' do
    following = Following.new({})
    expect(following).to be_a(Following)
  end
  it 'has name and url attributes' do
    following = Following.new({login: "bla", html_url: "http://www.website.com"})
    expect(following.name).to eq("bla")
    expect(following.url).to eq("http://www.website.com")
  end
end
