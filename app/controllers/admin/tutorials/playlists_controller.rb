class Admin::Tutorials::PlaylistsController < Admin::BaseController
  def new
    @tutorial = Tutorial.find(params[:tutorial_id])
  end

  def create
    tutorial = Tutorial.find(params[:tutorial_id])
    videos = YoutubeService.new.fetch_videos_for_playlist(params[:playlist_id])

    videos.each do |video_info|
      Video.create!({ tutorial: tutorial }.merge(video_info))
    end

    flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it here.', tutorial_path(tutorial))}"
    redirect_to admin_dashboard_path
  end
end
