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
      video_1 = create(:video, tutorial: tutorial, position: 3)
      video_2 = create(:video, tutorial: tutorial, position: 2)

      videos = Video.order_by_tutorial_id

      expect(videos.first).to eq(video_2)
      expect(videos.last).to eq(video_1)
    end
  end
end
