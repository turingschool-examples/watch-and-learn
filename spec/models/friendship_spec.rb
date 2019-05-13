require "rails_helper"

describe Friendship, type: :model do
  #healthy, jovial, supportive
  describe "relationships" do
    it {should belong_to :user}
  end

  describe "validations" do
    it {should validate_presence_of :user_id}
    it {should validate_presence_of :friend_id}
    it {should validate_presence_of :friend_login}
  end
end
