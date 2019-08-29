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

   def has_friend?(handle)
     self.friends.any? do |friend|
     friend.handle == handle
   end
 end
end
