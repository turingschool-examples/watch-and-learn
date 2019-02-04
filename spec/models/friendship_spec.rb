require 'rails_helper'

describe Friendship, type: :model do
  it 'users can have unidirectional friendships' do
    user_1 = create(:user)
    user_2 = create(:user)
    user_1.friends << user_2
    expect(user_1.friends).to eq([user_2])
    expect(user_2.friends).to eq([])
  end
end
