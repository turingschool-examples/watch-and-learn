require 'rails_helper'

describe 'Add Friend Call' do
  xit 'A logged in user cannot post with an invalid friend ID' do

    post "/friendships", {:params => {:friend_user_id => 'title'}}

    expect(response).to_not be_successful
  end
end
