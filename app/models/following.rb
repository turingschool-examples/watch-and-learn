class Following < ApplicationRecord
  belongs_to :user
  belongs_to :followed_user, class_name: 'User'

  validate :realism

  private

  def realism
    return unless user_id == followed_user_id
    errors.add :user, 'Only a solipsist would follow themselves.'
  end
end
