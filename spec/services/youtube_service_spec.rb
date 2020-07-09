require 'rails_helper'

describe YoutubeService do
  context "instance methods" do
    context "#video_info" do
      it "returns video data", :vcr do
        video_id = "dQw4w9WgXcQ"
        service = YoutubeService.new
        search = service.video_info(video_id)

        expect(search).to be_a Hash

        expect(search).to have_key :items
        expect(search[:items]).to be_an Array
        item = search[:items].first

        expect(item).to be_a Hash
        expect(item).to have_key :snippet
        expect(item[:snippet]).to be_a Hash
        expect(item[:snippet]).to have_key :thumbnails
        thumbnails = item[:snippet][:thumbnails]

        expect(thumbnails).to be_a Hash
        expect(thumbnails).to have_key :high
        expect(thumbnails[:high]).to be_a Hash
        expect(thumbnails[:high]).to have_key :url
        expect(thumbnails[:high][:url]).to be_a String
      end
    end

    context "#playlist_info" do
      it "returns one page of playlist data", :vcr do
        playlist_id = "PLLdPJGHquctExUP7PeLEu5bKIjhWTRZ6m"
        service = YoutubeService.new
        search = service.playlist_info(playlist_id)
        expect(search).to have_key :items
        expect(search[:items]).to be_an Array
        item = search[:items].first

        expect(item).to be_a Hash
        expect(item).to have_key :id
        expect(item[:id]).to be_a String
        expect(item).to have_key :snippet
        snippet = item[:snippet]

        expect(snippet).to be_a Hash
        expect(snippet).to have_key :title
        expect(snippet[:title]).to be_a String
        expect(snippet).to have_key :description
        expect(snippet[:description]).to be_a String
        expect(snippet).to have_key :thumbnails
        thumbnails = item[:snippet][:thumbnails]

        expect(thumbnails).to be_a Hash
        expect(thumbnails).to have_key :high
        expect(thumbnails[:high]).to be_a Hash
        expect(thumbnails[:high]).to have_key :url
        expect(thumbnails[:high][:url]).to be_a String
      end
    end

    context "#get_playlist_token" do
      it "returns a token", :vcr do
        playlist_id = "PLjiB1Gm1BUm_hM4HArla8kE7C-hdXsMAJ"
        service = YoutubeService.new
        search = service.playlist_info(playlist_id)
        token_search = service.get_playlist_token(playlist_id)

        expect(token_search).to eq(search[:nextPageToken])
      end
    end
  end
end
