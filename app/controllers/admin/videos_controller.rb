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

      conn = Faraday.new(url: 'https://www.googleapis.com') do |faraday|
      faraday.params[:part] = "snippet"
      faraday.params[:playlistId] = params[:playlist_id]
      faraday.params[:key] = ENV['YOUTUBE_API_KEY']
      end

      response = conn.get("youtube/v3/playlistItems")
      parsed = JSON.parse(response.body, symbolize_names: true)

      

      parsed[:items].map do |item|
        item[:snippet][:thumbnails][:default][:url]
        item[:snippet][:title]
        item[:snippet][:resourceId][:videoId]
        item[:snippet][:description]
      end

      binding.pry

   end




    begin
      tutorial = Tutorial.find(params[:tutorial_id])

      thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
      binding.pry
      video = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))

      video.save

      flash[:success] = 'Successfully created video.'
    rescue StandardError
      flash[:error] = 'Unable to create video.'
    end

    redirect_to edit_admin_tutorial_path(id: tutorial.id)

  end

  private

  def video_params
    params.permit(:position)
  end

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end
end
