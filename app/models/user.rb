# frozen_string_literal: true

class User < ApplicationRecord

  before_create :confirmation_token

  has_many :user_videos
  has_many :videos, through: :user_videos

  has_and_belongs_to_many :friendships,
                          class_name: "User",
                          join_table: :friendships,
                          foreign_key: :user_id,
                          association_foreign_key: :friend_user_id

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.all_github_usernames
    User.all.pluck(:github_username)
  end

  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end
end
