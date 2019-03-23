class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :tutorials, through: :videos

  has_one :github_token

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def self.github_uniq?(user, auth)
    self.where(uid: auth.uid).empty?
  end

  def bookmarks
     unordered_bookmarks = videos.includes(:tutorial)
    .order("videos.position asc")

    unordered_bookmarks.group_by {|video| video.tutorial}
  end

end
