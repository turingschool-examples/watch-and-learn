# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of :position }
  end

  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many :users }
    it { should belong_to :tutorial }
  end

  describe 'class methods' do
    it '.order_by_tutorial_id' do
      tutorial = create(:tutorial)
      video1 = create(:video, tutorial: tutorial, position: 3)
      video2 = create(:video, tutorial: tutorial, position: 2)

      videos = Video.order_by_tutorial_id

      expect(videos.first).to eq(video2)
      expect(videos.last).to eq(video1)
    end
  end

  describe 'instance methods' do
    it "#get_thumbnail", :vcr do
      video = create(:video, video_id: 'J7ikFUlkP_k')

      thumbnail = video.get_thumbnail

      expect(thumbnail).to be true
    end
  end
end
