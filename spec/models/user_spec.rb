require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end
  describe 'relationships' do
    it {should have_many(:user_videos)}
    it {should have_many(:videos).through(:user_videos)}
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
    it "#bookmark_videos" do
      tutorial = create(:tutorial)
      video_1 = create(:video, position: 2, tutorial: tutorial)
      video_2 = create(:video, position: 3, tutorial: tutorial)
      video_3 = create(:video, position: 0, tutorial: tutorial)
      video_4 = create(:video, position: 1, tutorial: tutorial)
      user = create(:user, github_token: ENV["GITHUB_TOKEN"])
      user_video_1 = UserVideo.create(user: user, video: video_1)
      user_video_2 = UserVideo.create(user: user, video: video_2)
      user_video_3 = UserVideo.create(user: user, video: video_3)
      # binding.pry
      expect(user.bookmark_videos).to eq([video_3, video_1, video_2])
    end
  end
end
