class ActivateController < ApplicationController
    def show
        if User.find(params[:user_id])
            User.update(status: 'active')
            flash[:success] = "Thank you! Your account is now activated."
        else
            flash[:error] = "Oops, something went wrong. Please try again."
        end
    end
end
