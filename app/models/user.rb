class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def repos
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{token}"
    end
    repo = conn.get('/user/repos')
    json = JSON.parse(repo.body, symbolize_names: true)
    list = []
    (1..5).each do |count|
      list << json[count][:full_name]
    end
    list
  end

  def followers
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{token}"
    end
    repo = conn.get('/user/followers')
    json = JSON.parse(repo.body, symbolize_names: true)
    list = []
    json.each do |follower|
      list << follower[:login]
    end
    list
  end
end
