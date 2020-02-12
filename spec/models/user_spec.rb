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

  describe "class methods" do
    it "has_follower_handle" do
      OmniAuth.config.test_mode = true
      user_1 = create(:user, github_handle: "jfangonilo")

      expect(User.has_handle?(user_1.github_handle)).to be(true)
      expect(User.has_handle?("danmoran-pro")).to be(false)
    end
  end
end
