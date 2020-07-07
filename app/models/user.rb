class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, on: :create, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }

  has_many :friended_users, foreign_key: :friend_id, class_name: 'Friend'
  has_many :friendees, through: :friended_users

  has_many :friending_users, foreign_key: :friendee_id, class_name: 'Friend'
  has_many :friends, through: :friending_users


  has_secure_password

  def self.from_omniauth(auto_info, current_user)

    github_user =  GithubUser.find_or_create_by(uid: auto_info.uid)
        github_user.uid          = auto_info.uid
        github_user.username     = auto_info.info.nickname
        github_user.token        = auto_info.credentials.token
        github_user.user         = current_user.id
        github_user.save
    end
  end
