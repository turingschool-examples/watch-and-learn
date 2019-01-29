class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def find_repos
    get_json('/user/repos')
  end
  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV["GITHUB_TOKEN"]
      faraday.headers["User-Agent"] = ENV["Faraday v0.15.4"]
      faraday.headers["Accept"] = ENV["application/vnd.github.v3+json"]
      faraday.adapter Faraday.default_adapter
    end
  end
end
