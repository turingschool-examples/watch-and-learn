class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if params[:video_id] == nil
      params[:video_id] = default_video.id
    end
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  private

  # def default_video
  #   binding.pry
  #   Video.first
  # end
end
