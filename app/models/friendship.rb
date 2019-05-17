# frozen_string_literal: true

# model for friendships
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friendship, class_name: 'User'
end
