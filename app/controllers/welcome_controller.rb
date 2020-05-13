class WelcomeController < ApplicationController
  def index
    @tutorials = if !current_user.nil?
                   filter_tutorials(params, true)
                 else
                   filter_tutorials(params, false)
                 end
  end

  private

  def page_limit
    { page: params[:page], per_page: 5 }
  end

  def filter_tutorials(params, logged_in)
    tutorials = if logged_in == true
                  Tutorial.all
                else
                  Tutorial.where(classroom: false)
                end
    tutorials = tutorials.tagged_with(params[:tag]) if params[:tag]
    tutorials.paginate(page_limit)
  end
end
