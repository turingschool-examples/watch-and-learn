# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :friend }
  end

  it 'does self-referential, one-way User relationship' do
    user1 = create(:user)
    user2 = create(:user)

    friendship1 = create(:friendship, user_id: user1.id, friend_id: user2.id)

    expect(user1.friendships).to eq([friendship1])
    expect(user1.friends).to eq([user2])

    expect(user2.friendships).to eq([])
    expect(user2.friends).to eq([])
  end
end
