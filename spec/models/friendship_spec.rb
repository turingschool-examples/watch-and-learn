RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:friendship_user_id) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :friendship_user }
  end
end
