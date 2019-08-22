class Api::V1::GithubReposController < ApplicationController
  def index
    render json: User.all
  end

end
