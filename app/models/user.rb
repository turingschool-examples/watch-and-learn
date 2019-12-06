class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true

  validates_presence_of :first_name,
                        :last_name,
                        :role

  enum role: [:default, :admin]
  has_secure_password

  def order_videos
    videos_ordered = videos.joins(:tutorial).group('tutorials.id, videos.id').order('tutorials.id', 'videos.position')
    videos_hash = Hash.new
    videos_ordered.each do |v|
      videos_hash[v.tutorial] ||= []
      videos_hash[v.tutorial] << v
    end
    videos_hash
  end
end
