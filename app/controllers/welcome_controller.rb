class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = public_tutorials(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = public_tutorials.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def public_tutorials(p = params)
    if current_user.nil?
      Tutorial.not_classroom
    else
      Tutorial.all
    end
  end
end
