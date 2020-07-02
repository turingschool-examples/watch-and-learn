require 'rails_helper'

describe 'Github Service' do
  describe '#fetch_repos_for_user' do
    it 'returns a list of user repositories' do
      fetched_repos = GithubService.new.fetch_repos_for_user
      first_repo = fetched_repos.first

      expect(fetched_repos).to be_an Array
      expect(first_repo).to be_a Hash
      expect(first_repo).to have_key :name
      expect(first_repo).to have_key :html_url
    end
  end
  describe '#fetch_followers_for_user' do
    it 'returns a list of followers' do
      fetched_followers = GithubService.new.fetch_followers_for_user
      first_follower = fetched_followers.first

      expect(fetched_followers).to be_an Array
      expect(first_follower).to be_a Hash
      expect(first_follower).to have_key :login
      expect(first_follower).to have_key :html_url
    end
  end
  describe '#fetch_following_for_user' do
    it 'returns a list of following' do
      fetched_following = GithubService.new.fetch_following_for_user
      first_follow = fetched_following.first

      expect(fetched_following).to be_an Array
      expect(first_follow).to be_a Hash
      expect(first_follow).to have_key :login
      expect(first_follow).to have_key :html_url
    end
  end
end
