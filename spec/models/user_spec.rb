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
        token: '76c651773528c96c30606689ccb4839d5ebe9182')
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
        token: '76c651773528c96c30606689ccb4839d5ebe9182')

      expect(user.followers).to eq(["alex-latham", "DavidTTran"])
    end
  end
end
