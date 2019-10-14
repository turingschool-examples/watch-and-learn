class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  #validate :realism

  private

  # def realism
  #   return unless user_id == followed_user_id
  #   errors.add :user, 'You may not follow yourself.'
  # end
end
