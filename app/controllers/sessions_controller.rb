# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    if params.include?("code")
      client_id     = "9018c6d8d3eaaafa37bf"
      client_secret = "64a05b150c4d3cff30c3f1b9acb32d385e50fe48"
      code          = params[:code]
      response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

      pairs = response.body.split("&")

      response_hash = {}

      pairs.each do |pair|
        key, value = pair.split("=")
        response_hash[key] = value
      end

      token = response_hash["access_token"]

      oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

      auth = JSON.parse(oauth_response.body)

      user          = User.find_or_create_by(uid: auth["id"])
      user.email = auth["login"]
      user.first_name = auth["login"]
      user.id = auth["id"]
      user.uid      = auth["id"]
      user.password_digest      = (0...50).map { ("a".."z").to_a[rand(26)] }.join
      user.last_name      = ""
      user.github_token    = token
      user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    elsif (User.find_by(email: params[:session][:email]))&.authenticate(params[:session][:password])
      user = User.find_by(email: params[:session][:email])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
