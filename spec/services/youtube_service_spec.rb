require 'rails_helper'

describe 'Youtube Service' do
  describe '#fetch_videos_for_playlist' do
    it 'returns a list of videos for playlist' do
      playlist_id = 'PLbt09tWqepBSRQstKuZjrOrX-9xNPY3CE'
      
      stubbed_videos = 
      [{ 
        snippet: { 
          title: "fake title",
          description: "this is a description",
          thumbnails: {
            default: 
              {
                url: "url"
              }
          },
          position: 5
        }, 
        id: 7
      }]
      

      expected_videos =  [{
        title: "fake title",
        description: "this is a description",
        thumbnail: "url",
        position: 5,
        video_id: 7
      }]

      allow_any_instance_of(YoutubeService).to receive(:playlist_video_info).and_return(stubbed_videos)
      fetched_videos = YoutubeService.new.fetch_videos_for_playlist(playlist_id)
      expect(fetched_videos).to eq(expected_videos)
    end
  end
end