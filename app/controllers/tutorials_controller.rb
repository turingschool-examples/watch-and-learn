# frozen_string_literal: true

class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    flash.now[:notice] = params[:flash_notice] unless params[:flash_notice].nil?
  end
end
