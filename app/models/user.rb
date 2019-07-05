# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  # validates :email, uniqueness: true, presence: true
  # validates_presence_of :password
  # validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.authenticate(auth_data)
    if auth_data
      # require "pry"; binding.pry
      user = User.find_or_create_by(uid: auth_data[:uid])
      user.uid = auth_data.uid
      user.username = auth_data.info.nickname
      user.email = auth_data.info.email
      user.token = auth_data.credentials.token
      user.save
      user
    else
      false
    end
  end
end
