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
  describe 'instance methods' do
    it '.on_our_site?' do
      user = create(:user, github_uid: 1)
      follower_1 = Follower.new({id: '1', login: "bla", html_url: "http://www.website.com"})
      follower_2 = Follower.new({id: '2', login: "bla", html_url: "http://www.website.com"})

      expect(follower_1.on_our_site?).to eq(true)
      expect(follower_2.on_our_site?).to eq(false)
    end
    it 'id' do
      user = create(:user, github_uid: 31)
      follower_1 = Follower.new({id: '31', login: "bla", html_url: "http://www.website.com"})
      expect(follower_1.id).to eq(user.id)
    end
  end
end
