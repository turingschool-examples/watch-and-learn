class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def repos
    conn = Faraday.new("https://api.github.com") do |req|
      req.headers["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
    end

    repos = conn.get("/user/repos")
    JSON.parse(repos.body, symbolize_names: true)
  end

end
