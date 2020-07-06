class GithubSessionsController < ApplicationController

  def create
    user = current_user
    info = request.env["omniauth.auth"]

    current_user.uid = info.uid
    current_user.username = info.info.nickname
    current_user.token = info.credentials.token
    current_user.save
    session[:user_id] = current_user.id
  
      redirect_to "/dashboard"
    end



  end






# def self.from_omniauth(auth_info)
#   where(uid: auth_info[:uid]).first_or_create do |new_user|
#     new_user.uid                = auth_info.uid
#     new_user.name               = auth_info.extra.raw_info.name
#     new_user.screen_name        = auth_info.extra.raw_info.screen_name
#     new_user.oauth_token        = auth_info.credentials.token
#     new_user.oauth_token_secret = auth_info.credentials.secret
#   end
# end
