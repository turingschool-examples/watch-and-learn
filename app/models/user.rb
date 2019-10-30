# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_credentials, dependent: :delete_all

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def add_credentials(auth_hash)
    credential = user_credentials.find_or_create_by(website: auth_hash["provider"])
    credential.update_attributes(token: auth_hash["credentials"]["token"])
  end

  def github_token
    credential = user_credentials.where(user_credentials: { website: "github" }).take
    credential.nil? ? nil : credential.token
  end
end
