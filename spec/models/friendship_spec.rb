require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:friend)}
  end

  describe 'instance methods' do
    it 'friend_themselves_check' do
      @user1 = create(:user, uid: '12')
      create(:github_token, user: @user1, token: ENV['USER_1_GITHUB_TOKEN'])

      @user2 = create(:user, uid: '34')

      friendship = Friendship.new(user: @user1, friend:@user1)

      expect(friendship.save).to eq(false)
      expect(friendship.errors.messages[:friendship].first).to eq("You cannot add yourself as a friend.")

    end
  end
end
