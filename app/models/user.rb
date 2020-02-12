class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friended_users, foreign_key: :friender_id, class_name: "FriendUser"
  has_many :friendees, through: :friended_users

  has_many :friending_users, foreign_key: :friendee_id, class_name: "FriendUser"
  has_many :frienders, through: :friending_users

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name

  enum role: %w[default admin]
  has_secure_password

  def find_friends

  end
end
