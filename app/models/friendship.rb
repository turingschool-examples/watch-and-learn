class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validate :friend_themselves_check

  private

  def friend_themselves_check
    if user && friend && user.uid == friend.uid
      errors.add(:friendship, "You cannot add yourself as a friend.")
    end
  end
end
