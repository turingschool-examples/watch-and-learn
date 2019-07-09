# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many :videos }
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

  describe 'class methods' do

    it ".all_github_usernames" do
      user_1 = create(:user, github_username: 'rocketman')
      user_2 = create(:user, github_username: 'jetman')

      usernames = User.all_github_usernames

      expect(usernames).to be_a Array

      expect(usernames.first).to eq('rocketman')
      expect(usernames.last).to eq('jetman')
    end

  end
end
