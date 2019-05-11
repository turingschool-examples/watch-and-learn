# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.from_omniauth(auth)
    user = where(username: auth['info']['nickname']).first
    if user.nil?
      create_from_omniauth(auth)
    else
      user.github_token = auth['credentials']['token']
    end
    user
  end

  def create_from_omniauth(auth)
    binding.pry
    create! do |user|
      user.github_token = auth['credentials']['token']
      user.username = auth['info']['nickname']
    end
  end
end
