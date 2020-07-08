class Admin::PlaylistsController < Admin::BaseController

  def new
  end

  def create
    tutorial = Tutorial.new(playlist_params)
    if tutorial.save
    playlist_data = YoutubeService.new.playlist_info(params[:playlist_id])
    @videos = playlist_data.each do |video_data|
      video_params = {
        :title => video_data[:snippet][:title],
        :description => video_data[:snippet][:description],
        :thumbnail => video_data[:snippet][:thumbnails][:default][:url],
        :video_id => video_data[:contentDetails][:videoId]
      }
      tutorial.videos.create(video_params)

    end
      flash[:notice] = %Q[Successfully created tutorial.<a href="/tutorials/#{tutorial.id}">View it here.</a>].html_safe
      redirect_to admin_dashboard_path
    else
      flash[:error] = tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def playlist_params
    params.permit(:title, :description, :playlist_id, :thumbnail)
  end
end
