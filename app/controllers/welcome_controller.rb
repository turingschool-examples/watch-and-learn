class WelcomeController < ApplicationController
  def index
    @tutorials = filter_by_tag(params)
  end

  private

  def page_limit
    { page: params[:page], per_page: 5 }
  end

  def filter_by_tag(params)
    if params[:tag]
      Tutorial.tagged_with(params[:tag]).paginate(page_limit)
    else
      Tutorial.all.paginate(page_limit)
    end
  end
end
