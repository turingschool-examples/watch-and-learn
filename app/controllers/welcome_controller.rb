# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @tutorials = if current_user
                   all_tutorials
                 else
                   non_classroom_tutorials
                 end
  end

  private

  def all_tutorials
    tag = params[:tag]
    if tag
      Tutorial.tagged_with(tag).paginate(page: params[:page], per_page: 5)
    else
      Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end

  def non_classroom_tutorials
    tag = params[:tag]
    if tag
      page = params[:page]
      Tutorial.non_classroom.tagged_with(tag).paginate(page: page, per_page: 5)
    else
      Tutorial.non_classroom.paginate(page: params[:page], per_page: 5)
    end
  end

  def show; end
end
