class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_and_belongs_to_many :friendships,
      class_name: "User",
      join_table:  :friendships,
      foreign_key: :user_id,
      association_foreign_key: :friend_user_id

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def connect_github(data)
    self.update!(github_token: data['credentials']['token'])
  end
end
