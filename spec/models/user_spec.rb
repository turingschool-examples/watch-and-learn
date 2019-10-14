# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many (:users).through(:friendships)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = described_class.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user).to be_default
    end

    it 'can be created as an Admin user' do
      admin = described_class.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin).to be_admin
    end
  end
end
