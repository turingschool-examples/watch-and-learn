require 'rails_helper'

describe Video do
  describe 'relationships' do
    it { should have_many(:user_videos) }
    it { should have_many(:users).through(:user_videos) }
    it { should belong_to(:tutorial) }
    it 'should be deleted when tutorial is deleted' do
      tutorial = create(:tutorial)
      video_1 = create(:video, tutorial: tutorial)
      video_2 = create(:video, tutorial: tutorial)

      expect(Video.all).to eq([video_1, video_2])
      tutorial.destroy

      expect(Video.all).to eq([])
    end
  end
end
