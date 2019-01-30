require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end
  describe 'class methods' do
    it '.user_in_database' do
      user_1 = create(:user)
      expect(User.user_in_database(user_1.username)).to eq(user_1)
    end
  end
  describe 'instance methods' do
    it '#user_not_friend' do
      user_1 = create(:user)
      user_2 = create(:user)
      expect(user_1.user_not_friend(user_2.username)).to eq(true)
      user_3 = create(:user, friends: [user_1])
      expect(user_3.user_not_friend(user_1.username)).to eq(false)
    end
  end
end
