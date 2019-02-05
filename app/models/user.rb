class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name

  enum role: [:default, :admin]

  has_secure_password

  def repositories
    if github_token
      GithubService.new(github_token).repositories.sample(5)
    else
      nil
    end
  end
end
