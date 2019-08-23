class WelcomeController < ApplicationController
  def index
    render locals: {
      facade: WelcomeTutorial.new(current_user, params)
    }
  end
end
