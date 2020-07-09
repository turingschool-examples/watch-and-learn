class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) },
           inverse_of: :tutorial, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail, presence: true

  def add_playlist_videos
    video_list = YouTube::Playlist.new(playlist_id).items
    video_list.each_with_index do |video, index|
      params = { title: video[:snippet][:title],
                 description: video[:snippet][:description],
                 video_id: video[:id],
                 thumbnail: video[:snippet][:thumbnails][:high][:url],
                 position: index + 1 }
      videos.create(params)
    end
  end
end
