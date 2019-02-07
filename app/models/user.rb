class User < ApplicationRecord
  before_create :create_activation_token
  
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def friends?
    !(friends.empty?)
  end
  
  private
  
  def create_activation_token
    self.activation_token = SecureRandom.base58
  end
end
