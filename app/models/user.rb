class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def github_repos
    return GithubService.new.github_repos(github_token) if github_token
    nil
  end

  def github_followers
    return GithubService.new.github_followers(github_token) if github_token
    nil
  end
end
