class WelcomeTutorial
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def tutorials
    if @current_user
      Tutorial.tagged_with(@params[:tag]).paginate(:page => @params[:page], :per_page => 5) if @params[:tag]
      Tutorial.all.paginate(:page => @params[:page], :per_page => 5)
    else
      Tutorial.regular.tagged_with(@params[:tag]).paginate(:page => @params[:page], :per_page => 5) if @params[:tag]
      Tutorial.regular.paginate(:page => @params[:page], :per_page => 5)
    end
  end
end
