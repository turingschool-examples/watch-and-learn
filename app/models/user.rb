# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.from_omniauth(user_id, auth)
    user = User.find(user_id)
    if user.username.nil?
      user.create_from_omniauth(auth)
    else
      user.update(github_token: auth['credentials']['token'])
    end
    user
  end

  def create_from_omniauth(auth)
    self.update!(github_token: auth['credentials']['token'])
    self.update!(username: auth['info']['nickname'])
  end

  def bookmarked_vids
    Video.joins(:users)
         .where(users: {id: self.id})
         .group(:id)
         .order(:tutorial_id)
         .order(:position)
  end
end
