require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
    it { should have_many(:friends)}
    it { should have_many(:friendships)}
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
    describe '.methods' do
        it 'can be get all github usernames' do
          user_1 = create(:user)
          user_1.update(github_username: "test user 1")
          user_2 = create(:user)
          user_2.update(github_username: "test user 2")
          user_3 = create(:user)

          expect(User.github_usernames).to eq(["test user 1", "test user 2"])
        end
    end
  end
end
