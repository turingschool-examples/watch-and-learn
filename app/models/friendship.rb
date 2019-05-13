class Friendship < ApplicationRecord
  belongs_to :user, touch: true, counter_cache: true
  belongs_to :friended_user, counter_cache: :friends_count, class_name: 'User'

  validate :narcissism


  private

  def narcissism
    return unless user_id == friended_user_id
    errors.add :user, 'Does everyone really need to know you are your friend?'
  end
end
