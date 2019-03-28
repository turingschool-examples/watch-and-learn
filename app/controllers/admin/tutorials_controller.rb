class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end


  def create
    if params[:tutorial][:playlist_id]
      create_tutorial_from_playlist
    else
      @tutorial = create_tutorial_from_input
    end

    if @tutorial.save
      save_videos

      flash[:message] = "Successfully created tutorial."

      redirect_to admin_dashboard_path
    else
      flash[:error] = "Tutorial could not be saved. Please check the playlist id and information."

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


  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail, :playlist_id)
  end

  def create_tutorial_from_input
    Tutorial.new(tutorial_params)
  end

  def create_tutorial_from_playlist
    playlist_id = params[:tutorial][:playlist_id]

    youtube_tutorial = YouTube::Tutorial.by_id(playlist_id)
    title = youtube_tutorial.title
    description = youtube_tutorial.description
    if description == ""
      description = "This tutorial has no description."
    end
    thumbnail = youtube_tutorial.thumbnail

    playlist_params = {title: title, description: description, thumbnail: thumbnail, playlist_id: playlist_id}

    @tutorial = Tutorial.new(playlist_params)

    tutorial_videos_data = YoutubeService.new.playlist_videos_info(playlist_id)

    @tutorial_videos = []
    tutorial_videos_data[:items].each do |tutorial_video|

      v_title = tutorial_video[:snippet][:title]
      v_description = tutorial_video[:snippet][:description]
      v_id = tutorial_video[:contentDetails][:videoId]
      v_thumbnail = tutorial_video[:snippet][:thumbnails][:high][:url]

      new_video_params = {title: v_title, description: v_description, thumbnail: v_thumbnail, video_id: v_id}

      @tutorial_videos << Video.new(new_video_params)
    end
  end

  def save_videos
    if @tutorial_videos
      @tutorial_videos.each do |video|
        video.tutorial_id = @tutorial.id
        video.save
      end
    end
  end
end
