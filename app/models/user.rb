# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friended_users, through: :friendships
  has_many :friends, foreign_key: :friended_user_id, class_name: 'Friendship'
  has_many :users_who_friended, through: :friendships, source: :user

  before_create :confirmation_token

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  enum email_confirmed: %i[inactive active]
  has_secure_password

  def email_activation
    self.email_confirmed = "active"
    self.confirm_token = nil
    save!(validate: false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
