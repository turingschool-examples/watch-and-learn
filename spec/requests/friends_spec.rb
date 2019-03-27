require 'rails_helper'

describe 'Add Friend Call' do
  it 'A logged in user cannot post with an INVALID friend ID' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    post "/friendships", {:params => {:friend_user_id => '123456'}}

    expect(response).to_not be_successful
  end

  it 'A logged in user cannot post with a VALID friend ID' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    post "/friendships", {:params => {:friend_user_id => '42525195'}}

    expect(response).to_not be_successful
  end


end
