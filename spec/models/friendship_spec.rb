require 'rails_helper'

RSpec.describe Friendship, type: :model do

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :friendship_user }
  end
end
