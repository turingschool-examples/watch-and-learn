# frozen_string_literal: true

class TutorialsController < ApplicationController
  def index
    @tutorials = if current_user
                   Tutorial.all
                 else
                   Tutorial.where("classroom = false")
                 end
  end

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
