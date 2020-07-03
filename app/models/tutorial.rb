class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def create_playlist_videos
    get_playlist_video_params.each do |params|
      self.videos.create(params)
    end
  end

  def get_playlist_video_json
    YoutubeService.new.playlist_items_info(self.playlist_id)
  end

  def get_playlist_video_params
    get_playlist_video_params = []
    get_playlist_video_json[:items].each do |video|
      video_params = {}
      video_params[:title] = video[:snippet][:title]
      video_params[:description] = video[:snippet][:description]
      video_params[:video_id] = video[:contentDetails][:videoId]
      video_params[:thumbnail] = video[:snippet][:thumbnails][:default][:url]
      video_params[:position] = video[:snippet][:position]
      get_playlist_video_params << video_params
    end
    get_playlist_video_params
  end
end
