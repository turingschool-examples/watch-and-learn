require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
    it {should have_many :friendships}
    it {should have_many(:friends).through(:friendships)}
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
    describe 'instance methods' do
      describe 'github_repos' do
        it "returns repo objects for first five repos associated with user's github token", :vcr do
          @repo_1 = Repo.new(name: 'activerecord-obstacle-course', url: "https://github.com/DanielEFrampton/activerecord-obstacle-course")
          @repo_2 = Repo.new(name: 'adopt_dont_shop', url: "https://github.com/DanielEFrampton/adopt_dont_shop")
          @repo_3 = Repo.new(name: 'adopt_dont_shop_paired', url: "https://github.com/DanielEFrampton/adopt_dont_shop_paired")
          @repo_4 = Repo.new(name: 'backend-curriculum-site', url: "https://github.com/DanielEFrampton/backend-curriculum-site")
          @repo_5 = Repo.new(name: 'backend_module_0_capstone', url: "https://github.com/DanielEFrampton/backend_module_0_capstone")

          expected = [@repo_1, @repo_2, @repo_3, @repo_4, @repo_5]
          user = create(:user, github_token: ENV['GITHUB_TOKEN'])

          actual = user.github_repos
          expect(actual.class).to eq(Array)
          expect(actual.length).to eq(5)

          actual.each_with_index do |repo, index|
            expect(repo.class).to eq(Repo)
            expect(repo.name).to eq(expected[index].name)
            expect(repo.url).to eq(expected[index].url)
          end
        end
      end

      describe 'github_followers' do
        it "returns follower objects for all followers associated with user's github token", :vcr do
          @follower_1 = Follower.new(name: 'msimon42', url: "https://github.com/msimon42")
          @follower_2 = Follower.new(name: 'danmoran-pro', url: "https://github.com/danmoran-pro")
          @follower_3 = Follower.new(name: 'jfangonilo', url: "https://github.com/jfangonilo")
          @follower_4 = Follower.new(name: 'aperezsantos', url: "https://github.com/aperezsantos")
          @follower_5 = Follower.new(name: 'sasloan', url: "https://github.com/sasloan")
          @follower_6 = Follower.new(name: 'PaulDebevec', url: "https://github.com/PaulDebevec")
          @follower_7 = Follower.new(name: 'rer7891', url: "https://github.com/rer7891")

          expected = [@follower_6, @follower_5, @follower_4, @follower_3, @follower_2, @follower_1, @follower_7]
          user = create(:user, github_token: ENV['GITHUB_TOKEN'])
          actual = user.github_followers
          expect(actual.class).to eq(Array)
          expect(actual.length).to eq(7)

          actual.each_with_index do |follower, index|
            expect(follower.class).to eq(Follower)
            expect(follower.name).to eq(expected[index].name)
            expect(follower.url).to eq(expected[index].url)
          end
        end
      end

      describe 'user_following' do
        it "returns follower objects for all followees associated with user's github token", :vcr do
          token = ENV['GITHUB_TOKEN']
          @follower_2 = Follower.new(name: 'msimon42', url: "https://github.com/msimon42")
          @follower_3 = Follower.new(name: 'jfangonilo', url: "https://github.com/jfangonilo")
          @follower_1 = Follower.new(name: 'ganelson', url: "https://github.com/ganelson")

          expected = [@follower_1, @follower_2, @follower_3]

          user = create(:user, github_token: ENV['GITHUB_TOKEN'])
          actual = user.github_following
          expect(actual.class).to eq(Array)
          expect(actual.length).to eq(3)

          actual.each_with_index do |followee, index|
            expect(followee.class).to eq(Follower)
            expect(followee.name).to eq(expected[index].name)
            expect(followee.url).to eq(expected[index].url)
          end
        end
      end

      describe 'name' do
        it 'returns full name if user' do
          user = create :user, first_name: 'Daniel', last_name: 'Frampton'

          expect(user.name).to eq('Daniel Frampton')
        end
      end
    end
  end
end
