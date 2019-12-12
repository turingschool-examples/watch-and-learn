require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:user_videos) }
    it { should have_many(:videos).through(:user_videos) }
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it '.status' do
      user = create(:user)
      user2 = create(:user, activated?: true)

      expect(user.status).to eq('Inactive')

      expect(user2.status).to eq('Active')
    end
  end
end
