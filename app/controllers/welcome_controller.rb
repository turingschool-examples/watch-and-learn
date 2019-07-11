# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if current_user
      @tutorials = all_tutorials
    else
      @tutorials = non_classroom_tutorials
    end
  end

  private

  def all_tutorials
    if params[:tag]
      Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end

  def non_classroom_tutorials
    if params[:tag]
      Tutorial.non_classroom.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      Tutorial.non_classroom.paginate(page: params[:page], per_page: 5)
    end
  end

  def show
  end
end
