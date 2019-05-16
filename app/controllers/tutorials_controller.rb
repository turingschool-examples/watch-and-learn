# frozen_string_literal: true

class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if current_user.nil? && tutorial.classroom?
      redirect_to root_path
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
