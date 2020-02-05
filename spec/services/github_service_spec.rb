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
    end
  end
end
