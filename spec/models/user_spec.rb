# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:uid) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      # rubocop:disable Metrics/LineLength
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)
      # rubocop:enable Metrics/LineLength

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      # rubocop:disable Metrics/LineLength
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)
      # rubocop:enable Metrics/LineLength
      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    describe '#set_activation_token' do
      it 'assigns a random, url-safe string to a user as an activation token' do
        user = create(:user)

        expect(user.activation_token).to eq(nil)

        user.set_activation_token

        expect(user.activation_token.is_a?(String)).to be(true)
      end
    end
  end
end
