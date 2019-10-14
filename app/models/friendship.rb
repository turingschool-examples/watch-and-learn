class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friendship_user, class_name: 'User'
end
