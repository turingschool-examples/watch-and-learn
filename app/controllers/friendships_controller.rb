class FriendshipsController < ApplicationController

  def create
    binding.pry
    new_friend = User.find_by(html_url: params["new_friend_url"])
  end
end
