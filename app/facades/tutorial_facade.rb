class TutorialFacade < SimpleDelegator
  def initialize(tutorial, video_id = nil)
    super(tutorial)
    @video_id = video_id
  end

  def current_video
    if videos.length == 0
      Video.new(title: "Sorry", description: "No video yet", video_id: 0, tutorial_id: 0, position: 0)
    elsif @video_id
      videos.find(@video_id)
    else
      videos.first
    end
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
    binding.pry
    videos.max_by { |video| video.position }.position
  end
end
