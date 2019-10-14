#
# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password


  has_many :friendships
  has_many :friendship_users, through: :friendships

  has_many :friendships, foreign_key: :friendship_user_id, class_name: 'Friendship'
  has_many :friendship_users, through: :friendships, source: :user
end
