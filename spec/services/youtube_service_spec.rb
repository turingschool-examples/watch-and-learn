require 'rails_helper'

RSpec.describe YoutubeService do
  it "gets youtube video info by id", :vcr do
    video = create(:video, video_id: 'RnvtXikwrIU')

    info = YoutubeService.new.video_info(video.video_id)

    title = info[:items].first[:snippet][:title]

    expect(title).to eq('Primitive Technology: Crossdraft kiln')
  end
end
