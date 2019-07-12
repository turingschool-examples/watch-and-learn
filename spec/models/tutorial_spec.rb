# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it 'produces no classroom tutorials if user is nil' do
      user = nil

      tutorial1 = create(:tutorial, classroom: false)
      create(:tutorial, classroom: true)

      expect(Tutorial.filtered(user).count).to eq(1)
      expect(Tutorial.filtered(user).first.id).to eq(tutorial1.id)
    end

    it 'produces all tutorials if user is in database' do
      user = create(:user)

      create(:tutorial, classroom: false)
      create(:tutorial, classroom: true)

      expect(Tutorial.filtered(user).count).to eq(2)
    end

    it 'organizes videos by tutorial in order of position' do
      user_1 = create(:user)
      user_2 = create(:user)

      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      tutorial_3 = create(:tutorial)
      tutorial_4 = create(:tutorial)

      video_1 = create(:video, position: 2, tutorial: tutorial_1)
      video_2 = create(:video, position: 1, tutorial: tutorial_1)
      video_3 = create(:video, position: 1, tutorial: tutorial_2)
      video_4 = create(:video, position: 2, tutorial: tutorial_2)
      video_5 = create(:video, position: 1, tutorial: tutorial_3)
      video_6 = create(:video, position: 2, tutorial: tutorial_3)

      video_7 = create(:video, position: 3, tutorial: tutorial_3)
      video_8 = create(:video, position: 3, tutorial: tutorial_4)

      create(:user_video, video: video_1, user: user_1)
      create(:user_video, video: video_2, user: user_1)
      create(:user_video, video: video_3, user: user_1)
      create(:user_video, video: video_4, user: user_1)
      create(:user_video, video: video_5, user: user_1)
      create(:user_video, video: video_6, user: user_1)
      create(:user_video, video: video_7, user: user_2)
      create(:user_video, video: video_8, user: user_2)

      tutorials =  Tutorial.tutorials_with_videos(user_1.id)

      expect(tutorials.count).to eq(3)
      expect(tutorials[0]).to eq(tutorial_1)
      expect(tutorials[1]).to eq(tutorial_2)
      expect(tutorials[2]).to eq(tutorial_3)

      expect(tutorials[0].videos.count).to eq(2)
      expect(tutorials[0].videos[0]).to eq(video_2)
      expect(tutorials[0].videos[1]).to eq(video_1)

      expect(tutorials[1].videos.count).to eq(2)
      expect(tutorials[1].videos[0]).to eq(video_3)
      expect(tutorials[1].videos[1]).to eq(video_4)
    end
  end
end
