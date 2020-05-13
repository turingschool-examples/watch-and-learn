class ActivationController < ApplicationController
  def update
    current_user.update(active: true)
  end

  def self.create(user)
    ActivationMailer.inform(user.full_name, user.email).deliver_now
  end
end
