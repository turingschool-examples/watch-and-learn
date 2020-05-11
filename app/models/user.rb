class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :token, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def repos
    service = GithubService.new(self)
    json = service.git_repos
    list = []
    (1..5).each do |count|
      list << json[count][:full_name]
    end
    list
  end

  def followers
    service = GithubService.new(self)
    json = service.git_followers
    json.map { |person| person[:login] }
  end

  def following
    service = GithubService.new(self)
    json = service.git_following
    json.map { |person| person[:login] }
  end

  def self.omniauth_token(auth_info)
    auth_info.credentials.token
  end

  def self.omniauth_username(auth_info)
    auth_info.extra.raw_info.login
  end

  def github?(github_account)
    User.exists?(username: github_account)
  end
end
