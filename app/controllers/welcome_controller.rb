# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.filtered(current_user).tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.filtered(current_user).paginate(page: params[:page], per_page: 5)
    end
  end
end
