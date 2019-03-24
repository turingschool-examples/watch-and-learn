require 'rails_helper'

describe GithubUser do

  it 'exists' do
    follower = GithubUser.new({})

    expect(follower).to be_a(GithubUser)
  end

  it 'has attributes' do
    follower = GithubUser.new({login: 'login', html_url: 'url', uid: 12})

    expect(follower.handle).to eq('login')
    expect(follower.url).to eq('url')
    expect(follower.uid).to eq(12)
  end
end
