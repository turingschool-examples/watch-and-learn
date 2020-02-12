require 'rails_helper'

RSpec.describe FriendUser, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :friend }
  end
end
