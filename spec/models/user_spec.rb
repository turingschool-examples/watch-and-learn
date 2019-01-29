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

  describe "Instance Methods" do
    it "#repositories" do
      VCR.use_cassette("github-user-repos") do
        user = create(:user, github_token: ENV["GITHUB_ACCESS_TOKEN"])

        repos = user.repositories
        expect(repos.count).to eq(5)

        repos.each do |repo|
          expect(repo).to be_a(Repository)
        end
      end
    end
  end
end
