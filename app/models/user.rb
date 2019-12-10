class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :email, uniqueness: true, presence: true

  validates_presence_of :first_name,
                        :last_name,
                        :role

  enum role: %i[default admin]
  has_secure_password

  def order_videos
    videos_ordered = videos.joins(:tutorial)
                           .group('tutorials.id, videos.id')
                           .order('tutorials.id', 'videos.position')
    videos_hash = {}
    videos_ordered.each do |v|
      videos_hash[v.tutorial] ||= []
      videos_hash[v.tutorial] << v
    end
    videos_hash
  end

  def friends_user?(id)
    return true if user_friends.find_by(friend_id: id)

    false
  end

  def user_friends
    @user_friends ||= friendships
  end

  def status
    return 'Active' if activated?
    return 'Inactive' unless activated?
  end
end
