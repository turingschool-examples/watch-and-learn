class User < ApplicationRecord
  before_create :confirmation_token
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
    User.where(id: get_friends_ids).order(:github_handle)
  end

  def my_tutorials
    Tutorial.joins(videos: :user_videos)
            .select("tutorials.*")
            .where(user_videos: {user_id: self.id})
            .distinct
  end

  def my_tutorial_videos(tutorial_id)
    Video.joins(:tutorial, :user_videos)
         .select("videos.*")
         .where(tutorials: {id: tutorial_id}, user_videos: {user_id: self.id})
         .order(:position)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!
  end

  def activated?
    self.email_confirmed == true
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
