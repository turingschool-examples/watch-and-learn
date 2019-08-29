class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'
  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :inverse_friends, :through => :inverse_friendships, class_name: 'User'
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  # def github_repos
  #   Merchant.select("merchants.*, count(invoices.merchant_id) as merchant_count").joins(invoices: :transactions).where(invoices: {customer_id: id }).where("transactions.result = ?", "success").group("merchants.id").order("merchant_count desc").first
  # end

  def github_update(auth_hash)
    self.token = auth_hash["credentials"]["token"]
  end

  def active
    if status == true
      'Active'
    else
      'Inactive'
    end
  end
end
