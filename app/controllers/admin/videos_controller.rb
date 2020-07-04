class Admin::VideosController < Admin::BaseController
  def edit
    @video = Video.find(params[:video_id])
  end

  def update
    video = Video.find(params[:id])
    video.update(video_params)
  end

  def create
    if params[:playlist_id] != nil
      begin
        search = YoutubeSearch.new
        video_info = search.playlist_videos(params[:playlist_id])
        tutorial = Tutorial.find(params[:tutorial_id])
        video_info.each do |video|
        video = tutorial.videos.new(video)
        video.save
        end
        flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it Here', "/tutorials/#{tutorial.id }")}."
      # rescue StandardError
      #   flash[:error] = 'Unable to create video.'
        redirect_to admin_dashboard_path
      end
    else
      begin
        tutorial = Tutorial.find(params[:tutorial_id])

        thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail

        video = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))

        video.save

        flash[:success] = 'Successfully created video.'
      rescue StandardError
        flash[:error] = 'Unable to create video.'
      end
      redirect_to edit_admin_tutorial_path(id: tutorial.id)
    end
  end

  private

  def video_params
    params.permit(:position)
  end

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end
end
