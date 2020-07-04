class Admin::PlaylistsController < Admin::BaseController

  def new
    @tutorial = Tutorial.new
  end
end
