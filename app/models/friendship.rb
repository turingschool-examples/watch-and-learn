class Friendship < ApplicationRecord
  belongs_to :user
  belogns_to :friend, class_name: 'User'

  validates :user_id, :friend_id, presence: true
end
