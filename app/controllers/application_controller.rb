# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :find_bookmark
  helper_method :list_tags
  helper_method :tutorial_name
  helper_method :check_user_in_database

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  def tutorial_name(id)
    Tutorial.find(id).title
  end

  def four_oh_four
    raise ActionController::RoutingError, 'Not Found'
  end

  def check_user_in_database(user)
    user = User.find_by(uid: user.uid)
    if user && !current_user.friends.include?(user)
      true
    else
      false
    end
  end

  def add_position_to_videos
    Video.where(position: nil).each { |video| video.update(position: 0) }
  end
end
