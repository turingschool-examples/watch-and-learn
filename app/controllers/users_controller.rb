# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @current_user = current_user
    # binding.pry
    # @bookmarks = @current_user.user_videos
    #                           .joins(:video)
    #                           .group("videos.tutorial_id")
    #                           .order("videos.position")

      @bookmarks =            @current_user.videos
                              .select("videos.tutorial_id, videos.title, videos.position")
                              .order(:position)
                              .group_by(&:tutorial_id)

                              # .where("user_videos.user_id = #{@current_user.id}")
      # @bookmarks = @current_user.videos
      #                           .joins(:users)
      #                           .select("videos.id, videos.title, videos.tutorial_id, user_videos.*, users.id")
      #                           .group(:tutorial_id)


    if @current_user.github_token?
      render locals: {
        repos: RepoFacade.new.create_repos(@current_user),
        followers: FollowersFacade.new.create_followers(@current_user),
        followed_accounts: FollowedAccountsFacade.new.create_followed_accounts(@current_user)
      }
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
