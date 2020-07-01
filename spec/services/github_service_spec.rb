require 'rails_helper'

describe 'Github Service' do
  describe '#fetch_repos_for_user' do
    it 'returns a list of user repositories' do
      fetched_repos = GithubService.new.fetch_repos_for_user
      first_repo = fetched_repos.first

      expect(fetched_repos).to be_an Array
      expect(first_repo).to be_a Hash
      expect(first_repo).to have_key :name
      expect(first_repo).to have_key :url
    end
  end
end
