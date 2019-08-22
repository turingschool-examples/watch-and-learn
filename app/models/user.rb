class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def authenticate(data)
    binding.pry
    self.attributes = {
      uid: data.uid.to_s,
      handle: data.info.nickname,
      token: data.credentials.token
    }
    self.save
  end

  def friendship_uids
    User.joins(:friendships).select('users.uid').where(friendships: {user_id: id})
  end
end
