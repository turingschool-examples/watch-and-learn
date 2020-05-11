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

  describe 'methods' do
    it 'can return an array of repos' do
      user = User.create(email: 'user@email.com',
        password: 'password',
        first_name:'Jim',
        role: 0,
        token: "#{ENV['GITHUB_TOKEN']}")
      expected = ["Maxwell-Baird/adopt_dont_shop_paired",
        "Maxwell-Baird/b2-mid-mod",
        "Maxwell-Baird/backend_module_0_capstone",
        "Maxwell-Baird/battleship",
        "Maxwell-Baird/black_thursday_lite"]
      expect(user.repos).to eq(expected)
    end

    it 'can return an array of followers' do
      user = User.create(email: 'user@email.com',
        password: 'password',
        first_name:'Jim',
        role: 0,
        token: "#{ENV['GITHUB_TOKEN']}")

      expect(user.followers).to eq(["alex-latham", "DavidTTran"])
    end

    it 'following' do
      user = User.create(email: 'user@email.com',
        password: 'password',
        first_name:'Jim',
        role: 0,
        token: "#{ENV['GITHUB_TOKEN']}")

      expect(user.following).to eq(["treyx", "tylertomlinson", 'kmcgrevey',"DavidTTran"])
    end

    it 'can_friend' do
      user1 = User.create(email: 'user@email.com',
        password: 'password',
        first_name:'Jim',
        role: 0,
        token: "#{ENV['GITHUB_TOKEN']}",
        username: 'Maxwell-Baird')
      user2 = User.create(email: 'user@email.com',
        password: 'password',
        first_name:'bob',
        role: 0,
        token: "#{ENV['GITHUB_TOKEN_2']}",
        username: 'kmcgrevey')

      expect(user2.can_friend('Maxwell-Baird')).to eq(true)
    end
  end
end
