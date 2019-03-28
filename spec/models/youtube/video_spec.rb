# frozen_string_literal: true

require 'rails_helper'

describe YouTube::Video, type: :model do
  before do
    @hash = { items: [snippet: { thumbnails: { high: { url: 'test' } } }] }
  end

  it 'exists' do
    video = YouTube::Video.new(@hash)

    expect(video.is_a?(YouTube::Video)).to be(true)
    expect(video.thumbnail).to eq('test')
  end

  describe 'instance methods' do
    describe '#by_id' do
      it 'returns a YouTube video by YouTube video id', :vcr do
        expect(YouTube::Video.by_id('dQw4w9WgXcQ').is_a?(YouTube::Video)).to be(true)
      end
    end
  end
end
