class FriendshipsController < ApplicationController
    def create
        @friendship = current_user.friendships.create!(friend_id: params[:friend_id])
        if @friendship.save
            flash[:notice] = "Added friend"
        else
            flash[:error] = "Unable to add friend"
        end
        redirect_to dashboard_path
    end
end
