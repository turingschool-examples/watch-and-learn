class TutorialFacade < SimpleDelegator
  def initialize(tutorial, video_id = nil)
    super(tutorial)
    @video_id = video_id
  end

  def current_video
    if videos == []
      Video.new(title: "Sorry", description: "No video", video_id: "0", thumbnail: "https://cdn.pixabay.com/photo/2016/02/08/17/43/sorry-1186962__340.jpg", tutorial_id: self.id, position: 1)
    elsif @video_id
      videos.find(@video_id)
    else
      videos.first
    end
  end

  def multiple_videos?
    videos != []
  end

  def next_video
    videos[current_video_index + 1] || current_video
  end

  def play_next_video?
    !(current_video.position >= maximum_video_position)
  end

  private

  def current_video_index
    videos.index(current_video)
  end

  def maximum_video_position
    videos.max_by { |video| video.position }.position
  end
end
