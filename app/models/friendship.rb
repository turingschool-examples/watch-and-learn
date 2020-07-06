class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friendship, class_name: User
end
