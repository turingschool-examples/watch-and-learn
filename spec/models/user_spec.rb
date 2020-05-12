require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
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

  describe 'instance methods' do
    it '#git_hub_token? returns true or false if user has a GH token' do
      user = create(:user)
      user1 = User.create({email: "fake@example.com",
                           first_name: "David",
                           last_name: "Tran",
                           password: "password",
                           role: "default",
                           token: ENV['GH_TEST_KEY_1']})

      expect(user.git_hub_token?).to eq(false)
      expect(user1.git_hub_token?).to eq(true)
    end
  end
end
