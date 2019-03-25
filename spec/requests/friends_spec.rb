require 'rails_helper'

describe 'Add Friend Call' do
  it 'A logged in user cannot post with an invalid friend ID' do

    post "/friendships", {:params => {:friend_github_uid => 'title'}}

    expect(response).to_not be_successful
  end
end
