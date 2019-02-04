class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, foreign_key: 'friend_id', through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  enum email_activation_status: [:unactivated, :active]
  has_secure_password

  def tutorials
    Tutorial.joins(videos: :users)
            .where(users: {id: self.id})
            .group(:id)
  end

  def name
    first_name + last_name
  end
end
