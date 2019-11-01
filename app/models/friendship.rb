# frozen_string_literal: true

# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  friend_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, :friend_id, presence: true

  after_create :create_inverse, unless: :inverses?
  after_destroy :destroy_inverse, if: :has_inverses?

  def create_inverse
    self.class.create(inverse_friend_options)
  end

  def destroy_inverse
    inverses.destroy_all
  end

  def inverses?
    self.class.exist?(inverse_friend_options)
  end

  def inverses
    self.class.where(inverse_friend_options)
  end

  def inverse_friend_options
    { friend_id: user_id, user_id: friend_id }
  end
end
