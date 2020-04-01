require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  describe 'relationships' do
    it {should belong_to :video}
    it {should belong_to :user}
  end

  describe 'class methods' do
    before(:each) do
      @user = create(:user)

      tutorial1 = create(:tutorial, title: "First Tutorial")
      @video1 = create(:video, title: "First on page", tutorial_id: tutorial1.id, position: 1)
      UserVideo.create!(user: @user, video: @video1)

      tutorial2 = create(:tutorial, title: "Second Tutorial")
      video2 = create(:video, title: "# 1", tutorial_id: tutorial2.id, position: 0)
      video3 = create(:video, title: "# 2", tutorial_id: tutorial2.id, position: 1)
      UserVideo.create!(user: @user, video: video2)
      UserVideo.create!(user: @user, video: video3)

      tutorial3 = create(:tutorial)
      no_bookmark_video = create(:video, tutorial_id: tutorial3.id)

      tutorial4 = create(:tutorial, title: "Third Tutorial")
      video4 = create(:video, title: "# 2", tutorial_id: tutorial4.id, position: 1)
      UserVideo.create!(user: @user, video: video4)
      video5 = create(:video, title: "Last on page", tutorial_id: tutorial4.id, position: 2)
      UserVideo.create!(user: @user, video: video5)
    end

    it '.get_bookmarked_video_info' do
      response = UserVideo.get_bookmarked_video_info(@user.id)
      
      expect(response.length).to eq(5)
      expect(response.first.video_id).to eq(@video1.id)
    end
  end
end
