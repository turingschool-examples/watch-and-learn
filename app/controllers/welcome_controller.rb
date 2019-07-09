# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @tutorials = paginated_tutorials
    @tutorials.tagged_with(params[:tag]) if params[:tag]
  end

  private

  def paginated_tutorials
    Tutorial.filtered(current_user).paginate(page: params[:page], per_page: 5)
  end
end
