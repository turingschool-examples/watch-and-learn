# frozen_string_literal: true

require 'rails_helper'

describe YouTube::Video, type: :model do
  before do
    @hash = { items: [snippet: { thumbnails: { high: { url: 'test' } } }] }
    @hash1 = {snippet: {thumbnails: {high: {url: 'this is url'}},
                        title: 'this is title',
                        description: 'this is description',
                        position: 'this is position'},
              contentDetails: {videoId: 2}}
  end

  it 'exists' do
    video = YouTube::Video.new(@hash)

    expect(video.is_a?(YouTube::Video)).to be(true)
    expect(video.thumbnail).to eq('test')
  end

  it 'has instance methods thumnail, video_id, title, description, position' do
    video = YouTube::Video.new(@hash1)
    expect(video).to be_a(YouTube::Video)
    expect(video.thumbnail).to eq('this is url')
    expect(video.video_id).to eq(2)
    expect(video.title).to eq('this is title')
    expect(video.description).to eq('this is description')
    expect(video.position).to eq('this is position')
  end

  describe 'instance methods' do
    describe '#by_id' do
      it 'returns a YouTube video by YouTube video id', :vcr do
        expect(YouTube::Video.by_id('dQw4w9WgXcQ').is_a?(YouTube::Video)).to be(true)
      end
    end
  end

  describe 'instance methods' do
    describe '#find_playlist_videos' do
      it 'returns a YouTube videos by YouTube Playlist ID', :vcr do
        expect(YouTube::Video.find_playlist_videos('PLpFmLQlYTnx-umq6uGwkhO7Cr_V7rwgyM').first).to be_a(YouTube::Video)
      end
    end
  end
end
