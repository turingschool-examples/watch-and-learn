# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if current_user
      @tutorials = Welcome.logged_in_tutorials(params)
    else
      @tutorials = Welcome.logged_out_tutorials(params)
    end
  end
end
