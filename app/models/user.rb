require_relative "./concerns/bookmarks_helper"

class User < ApplicationRecord
  include BookmarksHelper

  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def friendships?
    friendships.count > 0
  end

  def friend?(user_login)
    friendships.any? do |friend|
      friend.friend_login == user_login
    end
  end

  def get_bookmarks
    user_videos.joins(video: :tutorial)
    .select('tutorials.title as tutorial_title, tutorials.id as tutorial_id, videos.id, videos.title')
    .order('tutorials.id, videos.position')
  end

end
