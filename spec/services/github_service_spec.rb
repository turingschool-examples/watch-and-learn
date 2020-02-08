require 'rails_helper'

feature GithubService do
  feature 'methods' do
    feature 'instance methods' do
      feature 'user_repos' do
        scenario "returns repo objects for first five repos associated with user's github token", :vcr do
          token = ENV['GITHUB_TOKEN']
          @repo_1 = Repo.new(name: 'activerecord-obstacle-course', url: "https://github.com/DanielEFrampton/activerecord-obstacle-course")
          @repo_2 = Repo.new(name: 'adopt_dont_shop', url: "https://github.com/DanielEFrampton/adopt_dont_shop")
          @repo_3 = Repo.new(name: 'adopt_dont_shop_paired', url: "https://github.com/DanielEFrampton/adopt_dont_shop_paired")
          @repo_4 = Repo.new(name: 'backend-curriculum-site', url: "https://github.com/DanielEFrampton/backend-curriculum-site")
          @repo_5 = Repo.new(name: 'backend_module_0_capstone', url: "https://github.com/DanielEFrampton/backend_module_0_capstone")

          expected = [@repo_1, @repo_2, @repo_3, @repo_4, @repo_5]

          actual = GithubService.new.github_repos(token)
          expect(actual.class).to eq(Array)
          expect(actual.length).to eq(5)

          actual.each_with_index do |repo, index|
            expect(repo.class).to eq(Repo)
            expect(repo.name).to eq(expected[index].name)
            expect(repo.url).to eq(expected[index].url)
          end
        end
      end

      feature 'user_followers' do
        scenario "returns follower objects for all followers associated with user's github token", :vcr do
          token = ENV['GITHUB_TOKEN']
          @follower_1 = Follower.new(name: 'msimon42', url: "https://github.com/msimon42")
          @follower_2 = Follower.new(name: 'danmoran-pro', url: "https://github.com/danmoran-pro")
          @follower_3 = Follower.new(name: 'jfangonilo', url: "https://github.com/jfangonilo")
          @follower_4 = Follower.new(name: 'aperezsantos', url: "https://github.com/aperezsantos")
          @follower_5= Follower.new(name: 'sasloan', url: "https://github.com/sasloan")
          @follower_6 = Follower.new(name: 'PaulDebevec', url: "https://github.com/PaulDebevec")
          @follower_7 = Follower.new(name: 'rer7891', url: "https://github.com/rer7891")

          expected = [@follower_6, @follower_5, @follower_4, @follower_3, @follower_2, @follower_1, @follower_7]

          actual = GithubService.new.github_followers(token)
          expect(actual.class).to eq(Array)
          expect(actual.length).to eq(7)

          actual.each_with_index do |follower, index|
            expect(follower.class).to eq(Follower)
            expect(follower.name).to eq(expected[index].name)
            expect(follower.url).to eq(expected[index].url)
          end
        end
      end

      feature 'user_following' do
        scenario "returns follower objects for all followees associated with user's github token", :vcr do
          token = ENV['GITHUB_TOKEN']
          @follower_2 = Follower.new(name: 'msimon42', url: "https://github.com/msimon42")
          @follower_3 = Follower.new(name: 'jfangonilo', url: "https://github.com/jfangonilo")
          @follower_1 = Follower.new(name: 'ganelson', url: "https://github.com/ganelson")

          expected = [@follower_1, @follower_2, @follower_3]

          actual = GithubService.new.github_following(token)
          expect(actual.class).to eq(Array)
          expect(actual.length).to eq(3)

          actual.each_with_index do |followee, index|
            expect(followee.class).to eq(Follower)
            expect(followee.name).to eq(expected[index].name)
            expect(followee.url).to eq(expected[index].url)
          end
        end
      end
    end
  end
end
