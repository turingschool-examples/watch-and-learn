require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it "works" do
    user = create(:user)
    user_2 = create(:user, uid: 36653285)

    Friendship.create!(user: user, friend: user_2)

    expect(user.friends).to eq([user_2])
  end
end
