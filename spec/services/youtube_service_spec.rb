require "rails_helper"

describe YoutubeService do
  it "can do make an api call", :vcr do


    youtube_service = YoutubeService.new

    video = youtube_service.video_info(2)

    expect(video).to be_a(Hash)
    expect(video).to have_key(:kind)
  end
end