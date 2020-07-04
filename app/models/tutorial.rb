class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def create_playlist_videos
    playlist_video_params.each do |params|
      videos.create(params)
    end
  end

  def playlist_video_json
    YoutubeService.new.playlist_items_info(playlist_id)
  end

  def playlist_video_params
    playlist_video_params = []
    playlist_video_json[:items].each do |video|
      video_params = {}
      video_params[:title] = video[:snippet][:title]
      video_params[:description] = video[:snippet][:description]
      video_params[:video_id] = video[:contentDetails][:videoId]
      video_params[:thumbnail] = video[:snippet][:thumbnails][:default][:url]
      video_params[:position] = video[:snippet][:position]
      playlist_video_params << video_params
    end
    playlist_video_params
  end
end
