class User < ApplicationRecord
  has_many :user_videos
  has_many :tokens
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def friends_list
    friends + inverse_friends
  end

  def friended?(github_user)
    friends.where(id: github_user.id).take
  end
end
