class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_credentials

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

	def github_token
		cred = user_credentials
			.where(user_credentials: {website: "github"})
			.take
		cred.nil? ? nil : cred.token
	end
end
