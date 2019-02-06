class WelcomeFacade
  def initialize(user, params)
    @user = user
    @params = params
  end
  
  def tutorials  
    if @params[:tag]
      user_permitted_tutorials.tagged_with(@params[:tag]).paginate(:page => @params[:page], :per_page => 5)
    else
      user_permitted_tutorials.paginate(:page => @params[:page], :per_page => 5)
    end
  end
  
  def user_permitted_tutorials
    if @user
      Tutorial.all
    else
      Tutorial.where(classroom: false)
    end
  end
end