class WelcomeController < ApplicationController
  def index
    @facade = WelcomeFacade.new(current_user, params)
  end
end
