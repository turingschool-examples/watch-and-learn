require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:role)}
  end

  describe 'relationships' do
    it {should have_many :friendships}
    it {should have_many(:friends).through(:friendships)}
    it {should have_many :inverse_friendships}
    it {should have_many(:inverse_friends).through(:inverse_friendships)}
  end

  describe 'attributes' do
    it 'defaults to not connected' do
      user = create(:user)

      expect(user.connected?).to be_falsy
    end
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    before(:each) do
      @user = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)

      @tutorial = create(:tutorial)
      @video_1 = create(:video, tutorial_id: @tutorial.id)
      @video_2 = create(:video, tutorial_id: @tutorial.id)
      @video_3 = create(:video, tutorial_id: @tutorial.id)
      user_video_1 = create(:user_video, user_id: @user.id, video_id: @video_1.id)
      user_video_2 = create(:user_video, user_id: @user.id, video_id: @video_2.id)
      user_video_3 = create(:user_video, user_id: @user.id, video_id: @video_3.id)

      @tutorial_2 = create(:tutorial)
      @video_4 = create(:video, tutorial_id: @tutorial_2.id)
      @video_5 = create(:video, tutorial_id: @tutorial_2.id)
      @video_6 = create(:video, tutorial_id: @tutorial_2.id)
      user_video_4 = create(:user_video, user_id: @user.id, video_id: @video_4.id)
      user_video_5 = create(:user_video, user_id: @user.id, video_id: @video_5.id)
      user_video_6 = create(:user_video, user_id: @user.id, video_id: @video_6.id)

      create(:friendship, user_id: @user.id, friend_id: @user_2.id)
    end

    it 'order_videos' do
      videos_hash = {
        @tutorial => [@video_1, @video_2, @video_3],
        @tutorial_2 => [@video_4, @video_5, @video_6]
      }

      expect(@user.order_videos).to eq(videos_hash)
    end

    it 'friends_users?' do
      expect(@user.friends_user?(@user_2.id)).to eq(true)
      
      expect(@user.friends_user?(@user_3.id)).to eq(false)
    end

    it 'user_friends' do
      expect(@user.user_friends.first).to be_a(Friendship)
    end

    it 'status' do
      expect(@user.status).to eq('Inactive')
    end
  end
end
