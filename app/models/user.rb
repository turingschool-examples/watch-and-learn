class User < ApplicationRecord
  include CheckUser
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
    self.update!( github_uid: data["uid"],
                  github_token: data['credentials']['token'],
                  github_url: data['info']['urls']['GitHub'],
                  github_handle: data['extra']['raw_info']['login'] )
  end

  def has_friends?
    self.get_friends_ids.count > 0
  end

  def get_friends_ids
    Friendship.includes(:friend_user).select(:friend_user_id).where(user_id: self.id)
  end

  def get_friend_users
    User.where(id: get_friends_ids)
  end
end
