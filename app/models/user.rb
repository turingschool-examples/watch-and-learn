class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_credentials
	has_many :friendships
	has_many :friends, :through => :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

	def token(website)
		cred = user_credentials
			.where(user_credentials: {website: website})
			.take
		cred.nil? ? nil : cred.token
	end

  def add_credential(website, token)
    cred = self.user_credentials.find_or_create_by(website: website)
		cred.update_attributes(token: token)
  end
end
