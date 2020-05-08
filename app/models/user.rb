class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
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
    list = []
    json.each do |follower|
      list << follower[:login]
    end
    list
  end

  def following
    service = GithubService.new(self)
    json = service.git_following
    list = []
    json.each do |follower|
      list << follower[:login]
    end
    list
  end
end
