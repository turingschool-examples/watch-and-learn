# frozen_string_literal: true

<<<<<<< HEAD
module Admin
  # namespaced base controller
  class BaseController < ApplicationController
    before_action :require_admin!

    def require_admin!
      four_oh_four unless current_user.admin?
    end
  end
=======
class Admin::BaseController < ApplicationController

>>>>>>> dbd5e46932153cdc79f6b9b4cd8abe8657de42de
end
