# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  role            :integer          default("default")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  activate        :boolean          default(FALSE)
#

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_credentials, dependent: :delete_all
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :delete_all

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def add_credentials(auth_hash)
    credential = user_credentials.find_or_create_by(website: auth_hash["provider"])
    credential.update_attributes(token: auth_hash["credentials"]["token"])
    credential.update_attributes(nickname: auth_hash["info"]["nickname"])
  end

  def github_token
    credential = user_credentials.where(user_credentials: { website: "github" }).take
    credential.nil? ? nil : credential.token
  end

  def bookmarks
    #   videos.joins(:tutorial)
    #         .select("videos.*, tutorials.title AS tutorial_title")
    #         .order(position: :asc)

    Tutorial.includes(videos: :user_videos)
            .where(user_videos: { user_id: id })
  end
end
