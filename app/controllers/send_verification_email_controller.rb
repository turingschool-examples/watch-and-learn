class VerificationEmailController < ApplicationController
  def create
    VerificationEmailNotifierMailer.inform(current_user, params[:email]).deliver_now
    flash[:notice] = 'You Have Created An Account'
    redirect_to root_url
  end
end
