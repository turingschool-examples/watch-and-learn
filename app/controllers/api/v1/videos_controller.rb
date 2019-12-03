#  

class Api::V1::VideosController < ApplicationController
  def show
    render json: Video.find(params[:id])
  end
end
