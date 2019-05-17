class ActivationController < ApplicationController
  def index
    user = User.find(params[:user_id])
    user.update(status: true)
  end
end
