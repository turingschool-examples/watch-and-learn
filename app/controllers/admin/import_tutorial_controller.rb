class Admin::ImportTutorialController < Admin::BaseController
  def new
    @tutorial = Tutorial.new
  end

  def create
    tutorial = Tutorial.create(tutorial_params)

    youtube = YoutubeService.new
    video_list = youtube.playlist(params[:tutorial][:playlist_id])
    video_list.each do |video|
      tutorial.videos.create(new_video_params(video))
    end

    flash[:success] = 'Successfully created tutorial. '\
      "#{view_context.link_to('View it here', tutorial_path(tutorial))}."

    redirect_to '/admin/dashboard'
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:playlist_id,
                                     :title,
                                     :description,
                                     :thumbnail)
  end

  def new_video_params(vid)
    { title: vid[:snippet][:title],
      description: vid[:snippet][:description],
      video_id: vid[:snippet][:resourceId][:videoId],
      thumbnail: vid[:snippet][:thumbnails][:high][:url],
      position: vid[:snippet][:position] }
  end
end
