require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many(:users).through :user_videos }
    it { should belong_to :tutorial }
  end

  describe 'validations' do
    it { should validate_numericality_of :position }
  end

  describe 'class methods' do
    xit ".nillify" do
    tutorial = create(:tutorial)
    valid_position_video = create(:video, tutorial: tutorial, position: 1)
    invalid_position_video = create(:video, tutorial: tutorial, position: nil)

    Video.nillify

    expect(valid_position_video.position).to eq(1)
    expect(invalid_position_video.position).to eq(2)
    end

    it '.bookmarked_videos' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      video1 = create(:video, tutorial: tutorial1)
      video2 = create(:video, tutorial: tutorial2)
      video3 = create(:video, tutorial: tutorial2)
      user = create(:user)
      user2 = create(:user)
      UserVideo.create(user: user, video: video1)
      UserVideo.create(user: user, video: video2)
      UserVideo.create(user: user2, video: video3)

      expect(Video.bookmarked_videos(user)).to eq([video1, video2])
      expect(Video.bookmarked_videos(user2)).to eq([video3])
    end
  end
end
