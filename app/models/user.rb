class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key:  "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  validates_presence_of :username, allow_blank: true
  validates_presence_of :uid, allow_blank: true
  validates_presence_of :github_token, allow_blank: true
  enum role: [:default, :admin]
  has_secure_password

  def bookmarked
    videos.order(tutorial_id: :asc).order(position: :asc)
  end
end
