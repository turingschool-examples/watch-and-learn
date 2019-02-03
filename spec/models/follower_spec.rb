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
  it 'has can have nil user' do
    attributes = {
                    login: 'bob',
                    html_url: 'github.com'
                  }
    follower = Follower.new(attributes)

    expect(follower.user).to eq(nil)
  end
  it 'has user' do
    attributes = {
                    login: 'bob',
                    html_url: 'github.com',
                    id: '12345'
                  }
    user = create(:user, uid: '12345')
    follower = Follower.new(attributes)

    expect(follower.user).to eq(user)
  end

end
