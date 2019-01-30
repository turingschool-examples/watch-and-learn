class WelcomeController < ApplicationController
  def index
    if current_user
      @tutorials = all_videos
    else
      @tutorials = public_only_videos
    end
  end

  private

  def all_videos
    if params[:tag]
      Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      Tutorial.all.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def public_only_videos
    if params[:tag]
      Tutorial.tagged_with(params[:tag]).where('tutorials.classroom = ?', false).paginate(:page => params[:page], :per_page => 5)
    else
      Tutorial.all.where('tutorials.classroom = ?', false).paginate(:page => params[:page], :per_page => 5)
    end
  end
end
