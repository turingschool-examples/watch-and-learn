# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'does self-referential, one-way User relationship' do
    user_1 = create(:user)
    user_2 = create(:user)

    friendship_1 = create(:friendship, user_id: user_1.id, friend_id: user_2.id)

    expect(user_1.friendships).to eq([friendship_1])
    expect(user_1.friends).to eq([user_2])

    expect(user_2.friendships).to eq([])
    expect(user_2.friends).to eq([])
  end
end
