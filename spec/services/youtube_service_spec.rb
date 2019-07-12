# frozen_string_literal: true

require 'rails_helper'

describe YoutubeService do
  describe 'videos' do
    it "finds video info" do
      VCR.use_cassette('youtube_service_video_info_spec') do
        video = create(:video, video_id: "qMkRHW9zE1c")

        service = YoutubeService.new
        video_info = service.video_info(video.video_id)

        expect(video_info[:items].first[:id]).to eq(video.video_id)
      end
    end
  end
end
