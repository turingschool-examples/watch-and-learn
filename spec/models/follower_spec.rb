require 'rails_helper'

describe Follower do
  it 'exists' do
    attributes = {}
    follower = Follower.new(attributes)

    expect(follower).to be_a(Follower)
  end
  it 'has attributes' do
    attributes = {
                    login: 'bob',
                    html_url: 'github.com'
                  }
    follower = Follower.new(attributes)

    expect(follower.login).to eq('bob')
    expect(follower.html_url).to eq('github.com')
  end
end
