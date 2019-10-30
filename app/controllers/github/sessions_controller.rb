# frozen_string_literal: true

class Github::SessionsController < ApplicationController
  def create
    current_user.add_credentials(auth_hash)
    redirect_to dashboard_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
