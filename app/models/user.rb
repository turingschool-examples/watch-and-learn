class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Friendship'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Friendship'
  has_many :followers, through: :following_users

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
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

  def git_followers
    json = GithubService.followers(self.token)
    json.reduce([]) do |acc, user|
      if User.find_by(github_id: user['id'])
        acc << {name: user['login'], link: user['html_url'], github_id: user['id']}
      else
        acc << {name: user['login'], link: user['html_url']}
      end
      acc
    end
  end

  def git_following
    json = GithubService.following(self.token)
    json.reduce([]) do |acc, user|
      if User.find_by(github_id: user['id'])
        acc << {name: user['login'], link: user['html_url'], github_id: user['id']}
      else
        acc << {name: user['login'], link: user['html_url']}
      end
      acc
    end
  end

  def update_token(auth_hash)
    self.update!(token: auth_hash[:credentials][:token], github_id: auth_hash[:uid])
    self.save
  end

  def already_friends(github_id)
    user = User.find_by(github_id: github_id)
    !(self.followees.include?(user))
  end
end
