class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  enum status: [:unactivated, :active]
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
