require 'rails_helper'

RSpec.describe Friendship do
  it 'can be created with attributes' do
    attributes = {
      user_id: 1,
      friended_user_id: 2
      }

    friendship = Friendship.new(attributes)
    expect(friendship.user_id).to eq(1)
    expect(friendship.friended_user_id).to eq(2)
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friended_user_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:friended_user) }
  end
end
