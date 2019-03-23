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

  context 'instance methods' do
    it '#connect_github' do
      user = create(:user, email: "test@email.com", password: "test")

      data = {"provider"=>"github", "uid"=>"42525195",
        "credentials"=>{"token"=>"#{ENV['OAUTH_TEST_TOKEN']}", "expires"=>false}}

      expect(user.github_token).to eq(nil)

      user.connect_github(data)
      expect(user.github_token).to eq(ENV['OAUTH_TEST_TOKEN'])
    end
  end
end
