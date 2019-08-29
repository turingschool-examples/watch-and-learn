class InviteController < ApplicationController

  def new
     @invite = Invite.new
  end

  # 
  # def create
  #   UserMailer.notify(@user).deliver
  # end
end
