# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if current_user
      if params[:tag]
        @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
      else
        @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
      end
    else
      if params[:tag]
        @tutorials = Tutorial.non_classroom.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
      else
        @tutorials = Tutorial.non_classroom.paginate(page: params[:page], per_page: 5)
      end
    end
  end
end
