class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def authenticate(data)
    self.attributes = {
      uid: data.uid.to_s,
      handle: data.info.nickname,
      token: data.credentials.token
    }
    self.save
  end
end
