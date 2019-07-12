# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def destroy
    Tutorial.destroy(params[:id])
    redirect_to admin_dashboard_path
  end

  def edit
    if params[:video]
      @video = Video.new(video_params)
      @video.save
    else
      @video = Video.new
    end
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save
      flash[:message] = 'Successfully created tutorial.'
      redirect_to tutorial_path(@tutorial)
    else
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def video_params
    params.require(:video).permit(:title,
                                  :description,
                                  :video_id,
                                  :tutorial_id,
                                  :position)
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list,
                                     :title,
                                     :description,
                                     :thumbnail)
  end
end
