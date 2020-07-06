require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it {should belong_to :user}
    it {should belong_to :friend}
  end
end
# rails g migration CreateFriends friend_id:integer user:references
# rails g migration RenameFriendsToFriendships

# belongs_to :course
# belongs_to :prerequisite, class_name: Course
# end
# filename: app/models/course.rb
# class Course < ActiveRecord::Base
# # From Step 1
# has_many :course_prerequisites, class_name: Prerequisite
#
# # Step 2
# has_many :prerequisites, through: :course_prerequisites
#          source: prerequisite
