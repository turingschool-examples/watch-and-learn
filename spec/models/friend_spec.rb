require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :friend_user}
  end
end
