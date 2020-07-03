class Admin::YoutubePlaylistsController < Admin::BaseController
  def new
    @admin = current_user
  end

end
