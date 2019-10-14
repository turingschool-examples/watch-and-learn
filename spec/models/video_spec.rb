# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should validate_presence_of(:position) }

  describe "class method"
    it "can group videos by tutorial and orders them by position" do
      tutorial = create(:tutorial)
      tutorial_2 = create(:tutorial)
      tutorial_3 = create(:tutorial)
      video = create(:video, tutorial_id: tutorial.id, position: 1)
      video_2 = create(:video, tutorial_id: tutorial_2.id, position: 1)
      video_3 = create(:video, tutorial_id: tutorial_3.id, position: 2)
      video_4 = create(:video, tutorial_id: tutorial_3.id, position: 1)
      user = create(:user)

      expected_order = "Tutorial #{tutorial.id}\n#{video.title}\nTutorial #{tutorial_2.id}\n#{video_2.title}\nTutorial #{tutorial_3.id}\n#{video_4.title} #{video_3.title}"
      expect(Video.ordered_grouped_videos[1].pop.title).to eq(video.title)
    end
end
