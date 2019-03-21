require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  describe 'relationships' do
    it {should belong_to :user }
    it {should belong_to :video}
  end

  describe 'Class Methods' do
    it 'gets the users bookmarked videos' do
      user = create(:user)
      user2 = create(:user)

      tutorial1 = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)

      tutorial2 = create(:tutorial)
      video3 = create(:video, tutorial_id: tutorial2.id)

      tutorial3 = create(:tutorial)
      video4 = create(:video, tutorial_id: tutorial3.id)
      video5 = create(:video, tutorial_id: tutorial3.id)

      uv1 = create(:user_video, user: user, video: video1)
      uv2 = create(:user_video, user: user, video: video2)
      uv3 = create(:user_video, user: user, video: video4)
      uv4 = create(:user_video, user: user2, video: video3)

      expect(UserVideo.bookmarked_videos(user)).to eq([uv1, uv2, uv3])
    end
  end
end
