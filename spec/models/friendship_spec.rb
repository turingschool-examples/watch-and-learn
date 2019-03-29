# frozen_string_literal: true
require 'rails_helper'

describe Friendship do
  it 'exists' do
    user = create(:user)
    friend = create(:user)

    friendship = double(Friendship)
    allow(friendship).to receive_messages(:user => user, :friend=> friend)

    expect(friendship.user).to eq(user)
    expect(friendship.friend).to eq(friend)
  end
end
