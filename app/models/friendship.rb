class Friendship < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id,
                        :friend_id,
                        :friend_login
end
