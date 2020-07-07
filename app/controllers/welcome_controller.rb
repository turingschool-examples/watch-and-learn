class WelcomeController < ApplicationController
  def index
    @tutorials = Tutorial.filter_tutorials(params, current_user)
  end
end
