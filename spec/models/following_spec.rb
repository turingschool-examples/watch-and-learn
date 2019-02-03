require 'rails_helper'

describe Following do
  it 'exists' do
    attributes = {}
    following = Following.new(attributes)

    expect(following).to be_a(Following)
  end
  it 'has attributes' do
    attributes = {
                   login: 'bob',
                   html_url: 'github.com'
                 }
    following = Following.new(attributes)

    expect(following.login).to eq('bob')
    expect(following.html_url).to eq('github.com')
  end
  it 'can have nil user' do
    attributes = {
                   login: 'bob',
                   html_url: 'github.com'
                 }
    following = Following.new(attributes)

    expect(following.user).to eq(nil)
  end
  it 'can have user' do
    attributes = {
                   login: 'bob',
                   html_url: 'github.com',
                   id: '12345'
                 }
    user = create(:user, uid: '12345')
    following = Following.new(attributes)

    expect(following.user).to eq(user)
  end
end
