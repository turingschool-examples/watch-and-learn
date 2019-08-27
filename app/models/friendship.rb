class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validates_presence_of :user_id, :friend_id

  after_create :create_inverse, unless: :has_inverse?

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverse_match_options
    { user_id: friend_id, friend_id: user_id }
  end

  def create_inverse
    self.class.create(inverse_match_options)
  end
end
