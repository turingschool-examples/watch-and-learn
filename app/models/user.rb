class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_credentials
	has_many :friendships
	has_many :friends, :through => :friendships, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

	def friendable?(user)
		return user.user_id && !self.friends.exists?(id: user.user_id)
	end

	def token(website)
		cred = user_credentials
			.where(user_credentials: {website: website})
			.take
		cred.nil? ? nil : cred.token
	end

  def add_credential(website, user_info)
    cred = self.user_credentials.find_or_create_by(website: website)
		cred.update_attributes(token: user_info["credentials"]["token"])
		cred.update_attributes(nickname: user_info["info"]["nickname"])
  end

  def bookmarks
    Tutorial.includes(videos: :user_videos)
      .where(user_videos: {user_id: self.id})
  end
end
