# frozen_string_literal: true

module Admin
  module Api
    module V1
      # namespaced base controller
      class BaseController < ActionController::API
        before_action :require_admin!

        def require_admin!
          four_oh_four unless current_user.admin?
        end

        def current_user
          @current_user ||= if session[:user_id]
                              User.find(session[:user_id])
                            else
                              User.new
                            end
        end

        def four_oh_four
          raise ActionController::RoutingError, 'Not Found'
        end
      end
    end
  end
end
