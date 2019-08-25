class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => 'User'

	validates_presence_of :user_id
	validates_presence_of :friend_id

	after_create :create_inverse, unless: :has_inverse?
	after_destroy :destroy_inverses, if: :has_inverse?

	def create_inverse
		self.class.create(inverse_friend_options)
	end

	def destroy_inverses
		inverses.destroy_all
	end

	def has_inverse?
		self.class.exists?(inverse_friend_options)
	end

	def inverses
		self.class.where(inverse_friend_options)
	end

	def inverse_friend_options
		{ friend_id: user_id, user_id: friend_id }
	end
end
