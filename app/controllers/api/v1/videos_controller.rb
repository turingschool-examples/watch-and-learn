# frozen_string_literal: true

module Api
  module V1
    class VideosController < ApplicationController
      def show
        render json: Video.find(params[:id])
      end
    end
  end
end
