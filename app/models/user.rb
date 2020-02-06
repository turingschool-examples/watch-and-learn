class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password


  def repositories
    json = GithubService.repos(self.token)
    repositories = json.reduce([]) do |acc, repo|
      acc << {name: repo['name'], link: repo['html_url']}
      acc
    end
    repositories[0..4]
  end

  def followers
    json = GithubService.followers(self.token)
    json.reduce([]) do |acc, user|
      acc << {name: user['login'], link: user['html_url']}
      acc
    end
  end

  def following
    json = GithubService.following(self.token)
    json.reduce([]) do |acc, user|
      acc << {name: user['login'], link: user['html_url']}
      acc
    end
  end
end
