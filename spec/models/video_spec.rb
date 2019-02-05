require "rails_helper"
describe Video, type: :model do
  describe 'relationships' do
    it { should have_many :user_videos}
    it { should have_many :users}
  end
  describe 'class methods' do
    it '.update_each_position' do
      tut_1 = create(:tutorial)
      tut_2 = create(:tutorial)

      video_1 = create(:video, position: 1, tutorial: tut_1)
      video_2 = create(:video, position: 2, tutorial: tut_1)
      video_3 = create(:video, position: 4, tutorial: tut_1)
      video_4 = create(:video, position: nil, tutorial: tut_1)
      video_5 = create(:video, position: 0, tutorial: tut_1)
      video_6 = create(:video, position: 0, tutorial: tut_1)

      video_7 = create(:video, position: 0, tutorial: tut_2)
      video_8 = create(:video, position: 1, tutorial: tut_2)

      update_count = Video.update_each_position
      expect(update_count).to eq(4)
      expect(video_1.reload.position).to eq(video_1.position)
      expect(video_2.reload.position).to eq(video_2.position)
      expect(video_3.reload.position).to eq(video_3.position)

      expect(video_4.reload.position).to eq(5)
      expect(video_5.reload.position).to eq(6)
      expect(video_6.reload.position).to eq(7)

      expect(video_7.reload.position).to eq(2)
      expect(video_8.reload.position).to eq(video_8.position)
    end
  end
end
