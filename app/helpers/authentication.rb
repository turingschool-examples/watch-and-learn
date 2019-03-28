# frozen_string_literal: true

module Helpers
  module Authentication
    def login_as(user)
      visit login_path
      fill_in :session_email, with: user.email
      fill_in :session_password, with: user.password
      click_button 'Log In'
    end

    def logout; end
  end
end
