require 'rails_helper'

describe Follower do

  it 'exists' do
    follower = Follower.new({})

    expect(follower).to be_a(Follower)
  end

  it 'has attributes' do
    follower = Follower.new({login: 'login', html_url: 'url'})

    expect(follower.handle).to eq('login')
    expect(follower.url).to eq('url')
  end
end
