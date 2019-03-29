# frozen_string_literal: true

require 'rails_helper'

describe YoutubeService do
  it 'exists' do
    service = YoutubeService.new
    expect(service).to be_a(YoutubeService)
  end

  context 'instance methods' do
    context '#playlist_videos(playlist_id)' do
      it 'returns videos', :vcr do
        create(:user, github_token: ENV['github_key'])

        service = YoutubeService.new

        result = service.playlist_videos('PLpFmLQlYTnx-umq6uGwkhO7Cr_V7rwgyM')
        expect(result).to be_a(Array)
        expect(result.count).to eq(3)
        expect(result.first).to have_key(:snippet)
        expect(result.first).to have_key(:contentDetails)
      end
    end
  end
end
