# frozen_string_literal: true

class Friendship < ApplicationRecord
  validates_presence_of :user_id
  validates_presence_of :friend_user_id
  validates_uniqueness_of :friend_user_id, scope: %i[user_id friend_user_id]
end
