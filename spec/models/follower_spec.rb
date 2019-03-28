require 'rails_helper'

describe "Follower", type: :model do
  describe "instance methods" do
    before :each do
      @user = create(:user, github_uid: "98765")
      @already_friend = create(:user, github_uid: "11111")
      @not_friend = create(:user, github_uid: "22222")

      @following1 = {:login=>"test1login",
        :id=>11111,
        :html_url=>"https://github.com/test1login",
      }
      @following2 = {:login=>"test2login",
        :id=>22222,
        :html_url=>"https://github.com/test2login",
      }

      @follow1 = Follower.new(@following1)
      @follow2 = Follower.new(@following2)

      @friendship = create(:friendship, user: @user, friend_user: @already_friend)
    end

    it "#not_a_friend?" do
      expect(@follow1.not_a_friend?(@user.id)).to eq(false)
      expect(@follow2.not_a_friend?(@user.id)).to eq(true)
    end

    it "#get_user_id" do
      expect(@follow1.get_user_id).to eq(@already_friend.id)
      expect(@follow2.get_user_id).to eq(@not_friend.id)
    end
  end
end
