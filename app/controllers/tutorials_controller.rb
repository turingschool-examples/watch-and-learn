# frozen_string_literal: true

class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if current_user && tutorial.classroom == true
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    elsif !current_user && tutorial.classroom == true
      render file: "/public/404" unless current_user
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
