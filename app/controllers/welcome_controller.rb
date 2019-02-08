class WelcomeController < ApplicationController
  def index
    if params[:tag]
      set_tutorials_when_tag
    else
      set_tutorials_when_no_tag
    end
  end

  private

  def set_tutorials_when_tag
    if current_user
      @tutorials = paginate(Tutorial.tagged_with(params[:tag]))
    else
      @tutorials = paginate(visitor_tutorials.tagged_with(params[:tag]))
    end
  end

  def set_tutorials_when_no_tag
    if current_user
      @tutorials = paginate(Tutorial.all)
    else
      @tutorials = paginate(visitor_tutorials)
    end
  end

  def paginate(tutorials)
    tutorials.paginate(:page => params[:page], :per_page => 5)
  end

  def visitor_tutorials
    Tutorial.no_classroom_content
  end
end
