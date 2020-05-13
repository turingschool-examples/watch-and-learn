class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def git_hub_token?
    !self[:token].nil?
  end

  def update_auth(response)
    self.update(uid: response[:uid], token: response[:credentials][:token])
  end

  def full_name 
    "#{self.first_name}" + " " + "#{self.last_name}"
  end
end
