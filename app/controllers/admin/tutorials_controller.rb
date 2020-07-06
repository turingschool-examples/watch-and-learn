class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(title: params[:tutorial][:title],
                    description: params[:tutorial][:description],
                    thumbnail: params[:tutorial][:thumbnail])
    
    if tutorial.save
      #tutorial_videos = YoutubeService.new.playlist_items_with_thumbnail(tutorial.id, tutorial)
      redirect_to "/tutorials/#{tutorial.id}"
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

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
