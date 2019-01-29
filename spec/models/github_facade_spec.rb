require 'rails_helper'

describe GithubFacade, type: :model do
  it 'exists' do
    github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"])
    expect(github_facade).to be_a(GithubFacade)
  end
  describe 'instance methods' do
    context '#repos' do
      it 'returns num of github repos given valid key' do
        github_facade = GithubFacade.new(ENV["GITHUB_API_KEY"])
        expect(github_facade.repos.count).to eq(5)
        expect(github_facade.repos(7).count).to eq(7)
        expect(github_facade.repos.first).to be_a(Repo)
      end
    end
  end
end
