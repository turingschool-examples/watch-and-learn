class User < ApplicationRecord
  has_many :user_videos
  has_one :github_value
  has_many :videos, through: :user_videos
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_many :friendships
  has_many :friends, through: :friendships

  has_secure_password

  def handle_exists?(handle)
    if User.find_by(handle: handle)
      true
    else
      false
    end
  end

  def has_friend?(handle)
    self.friends.any? do |friend|
      friend.handle == handle
    end
  end


  def validate_user
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def set_confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
