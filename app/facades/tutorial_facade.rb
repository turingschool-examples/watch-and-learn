# frozen_string_literal: true

# class level documentation comment
class TutorialFacade < SimpleDelegator
  def initialize(tutorial, video_id = nil)
    super(tutorial)
    @video_id = video_id
  end

  def current_video
    if videos.count.zero?
      videos << Video.new(title: 'More to come', description: "It's a secret")
      videos.first
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
    current_video.position < maximum_video_position
  end

  private

  def current_video_index
    videos.index(current_video)
  end

  def maximum_video_position
    if Video.order(position: :desc).first.position.nil?
      new_position = Video.order(position: :desc)
                          .second[:position] + 1
      Video.order(position: :desc).first.update(position: new_position)
    end
    find_max_vid_position
  end

  def find_max_vid_position
    Video.order(position: :desc).first.position
  end
end
