class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name,
                        :last_name,
                        :role

  enum role: [:default, :admin]
  has_secure_password
end
