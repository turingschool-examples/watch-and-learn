class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, on: :create, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }

  has_many :friends
  has_many :friends, through: :friends

  has_many :friended_users
  has_many :friended_users, through: :friended_users, source: :user


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
