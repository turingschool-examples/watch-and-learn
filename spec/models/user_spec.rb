# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many(:friendships) }
    it { should have_many(:friended_users) }
    it { should have_many(:friends) }
    it { should have_many(:users_who_friended) }
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

    it "user starts with nil github_token" do
      user = create(:user)

      expect(user.github_token).to eq(nil)
    end
  end

  describe 'instance methods' do
    it "email_activation" do
      user = create(:user, confirm_token: "12345qwadflkawe")

      expect(user.email_confirmed).to eq("inactive")

      user.email_activation

      expect(user.email_confirmed).to eq("active")
      assert_nil(user.confirm_token)
    end
  end
end
