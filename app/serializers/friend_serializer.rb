class FriendSerializer < ActiveModel::Serializer
  attributes :id, :user_friend_id, :user_id
end
